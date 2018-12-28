import 'package:scoped_model/scoped_model.dart';
import 'package:weather/models/weather.dart';

class WeatherModel extends Model{
  List<Weather> _weatherList = [
    Weather(id: 1, title: "Berlin", countryCode: 'DE', status: WeatherStatus.SUNNY, temp: "30°C"),
    Weather(id: 2, title: "Saarbrücken", countryCode: 'DE', status: WeatherStatus.CLOUDY, temp: "30°C")
  ];
  
  List<Weather> get weatherList{
    // returns a new copy of the list
    return _weatherList.toList();
  }

  loadWeatherList(){

  }

  _persistWeatherList(){
     // persists current weather list to disk
  }

  void addWeather(Weather w){
    _weatherList.add(w);
    _persistWeatherList();
    notifyListeners();
  }

  void removeWeather(int index){
    _weatherList.removeAt(index);
    _persistWeatherList();
    notifyListeners();
  }
}