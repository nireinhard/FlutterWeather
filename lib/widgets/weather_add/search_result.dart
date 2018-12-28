import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather/scoped-models/weather_model.dart';
import 'package:weather/models/weather.dart';

class SearchResult extends StatelessWidget {
  final Weather _weather;

  SearchResult(this._weather);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WeatherModel>(
      builder: (BuildContext context, Widget child, WeatherModel model) {
        return Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("${_weather.title}, ${_weather.countryCode}"),
              FlatButton(
                child: Icon(Icons.add),
                onPressed: () {
                  model.addWeather(_weather);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
