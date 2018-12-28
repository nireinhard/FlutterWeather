import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class WeatherPreview extends StatelessWidget {
  final Weather _weather;

  WeatherPreview(this._weather);

  String _getImage(){
    if(_weather.status == WeatherStatus.SUNNY){
      return 'assets/sunny.jpg';
    }else if(_weather.status == WeatherStatus.CLOUDY){
      return 'assets/cloudy.jpg';
    }else{
      return 'assets/sunny.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_getImage()),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
        ),
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
