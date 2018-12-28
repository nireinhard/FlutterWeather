import 'package:flutter/material.dart';
import 'package:weather/pages/weather_list.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather/scoped-models/weather_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<WeatherModel>(
        model: WeatherModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather',
            theme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue,
                textTheme: TextTheme(body1: TextStyle(color: Colors.white))),
            home: WeatherList()));
  }
}
