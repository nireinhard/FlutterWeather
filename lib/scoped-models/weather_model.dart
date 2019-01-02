import 'package:scoped_model/scoped_model.dart';
import 'package:weather/models/weather.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/widgets/utility/converter.dart';
import 'package:weather/widgets/utility/weather.dart';
import 'package:localstorage/localstorage.dart';

class WeatherModel extends Model {
  List<Weather> _weatherList = [];

  _getDataFromApi(Weather w) async {
    http.Response weatherResponse = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=${w.title},${w.countryCode}&APPID=bcce0e3e45b54cf1c6d55eeb1be2307d");
    http.Response forecastResponse = await http.get(
        "http://api.openweathermap.org/data/2.5/forecast?q=${w.title},${w.countryCode}&APPID=bcce0e3e45b54cf1c6d55eeb1be2307d");
    Map<String, dynamic> weatherData = json.decode(weatherResponse.body);
    Map<String, dynamic> forecastData = json.decode(forecastResponse.body);
    print(weatherData);
    w.status =
        WeatherUtility.parseWeatherStatusCode(weatherData['weather'][0]['id']);
    w.stats.putIfAbsent("sunrise",
        () => Converter.timeStamp2Readable(weatherData["sys"]["sunrise"]));
    w.stats.putIfAbsent("sunset",
        () => Converter.timeStamp2Readable(weatherData["sys"]["sunset"]));
    w.stats.putIfAbsent("sunsettimestamp", () => weatherData["sys"]["sunset"]);
    w.stats.putIfAbsent("humidity", () => weatherData["main"]["humidity"]);
    w.stats.putIfAbsent("pressure", () => weatherData["main"]["pressure"]);
    w.stats.putIfAbsent("clouds", () => weatherData['clouds']['all']);
    w.temp = Converter.k2Celsius(weatherData['main']['temp']);

    // remove all items from list, as this method is called to refresh data
    // and therefore would put in items multiple times when not clearing the list before adding
    w.todayforecast.removeWhere((_) => true);

    forecastData['list'].forEach((forecast) {
      var today = DateTime.now();
      if (DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000).day ==
          today.day) {
        ForecastData forecastObject = ForecastData(
          forecast['dt'],
          Converter.k2Celsius(forecast['main']['temp']),
          WeatherUtility.parseWeatherStatusCode(forecast['weather'][0]['id']),
        );
        w.todayforecast.add(
          forecastObject,
        );
      } else {
        w.addWeekdayForecast(
            DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000).weekday,
            forecast['dt'],
            WeatherUtility.parseWeatherStatusCode(forecast['weather'][0]['id']),
            Converter.k2CelsiusRounded(forecast['main']['temp']));
      }
    });

    notifyListeners();
  }

  List<Weather> get weatherList {
    // returns a new copy of the list
    return _weatherList;
  }

  Future<void> refreshWeatherList() {
    return Future.forEach(_weatherList, (Weather w) => _getDataFromApi(w));
  }

  Future<void> loadWeatherList() async {
    final LocalStorage _storage = LocalStorage('weather_app');
    await _storage.ready;
    List list = await _storage.getItem("weatherlist");
    List<Weather> decodedList = list.map<Weather>((json) {
      Weather w = Weather.fromJson(jsonDecode(json));
      return w;
    }).toList();
    _weatherList = decodedList;
    await refreshWeatherList();
    notifyListeners();
  }

  Future<void> _persistWeatherList() async {
    final LocalStorage _storage = LocalStorage('weather_app');
    await _storage.ready;
    List<String> jsonList =
        _weatherList.map<String>((Weather w) => jsonEncode(w)).toList();
    await _storage.setItem("weatherlist", jsonList);
  }

  void addWeather(Weather w) {
    _weatherList.add(w);
    _loadWeatherData(w);
    _persistWeatherList();
    notifyListeners();
  }

  void _loadWeatherData(Weather w) {
    _getDataFromApi(w);
    notifyListeners();
  }

  void removeWeather(int index) {
    _weatherList.removeAt(index);
    _persistWeatherList();
    notifyListeners();
  }
}
