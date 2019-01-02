import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/widgets/utility/weather.dart';

class WeatherPreview extends StatelessWidget {
  final Weather _weather;

  WeatherPreview(this._weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: WeatherUtility.getBackgroundTheme(_weather.stats['sunsettimestamp'], _weather.status).item2,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(_weather.title, style: TextStyle(fontSize: 30.0)),
              flex: 3),
          Expanded(
              child: Text(_weather.temp == null ? "-- °C" : _weather.temp, style: TextStyle(fontSize: 30.0)),
              flex: 1),
        ],
      ),
    );
  }
}
