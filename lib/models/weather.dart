import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/widgets/utility/converter.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';

part 'weather.g.dart';

enum WeatherStatus{
  SUNNY, CLOUDY, RAINY, STORMY, SNOWY
}

class ForecastData{
  final int timeStamp;
  final String temp;
  final WeatherStatus status;
  
  String get getTimeStamp => Converter.timeStamp2Readable(timeStamp);

  ForecastData(this.timeStamp, this.temp, this.status);
}

class WeekdayForecast{
  final int weekday;
  final int timeStamp;
  final WeatherStatus status;
  List<int> temps;

  int get getWeekday => DateTime.fromMillisecondsSinceEpoch(timeStamp*1000).weekday;
  int get minTemp => temps.isNotEmpty ? temps.reduce(min) : 0;
  int get maxTemp => temps.isNotEmpty ? temps.reduce(max) : 0;

  WeekdayForecast(this.weekday, this.timeStamp, this.status){
    this.temps = [];
  }
}

@JsonSerializable()
class Weather {
  final int id;
  final String title;
  final String countryCode;
  String temp;
  WeatherStatus status;
  Map<String, dynamic> stats;
  List<ForecastData> todayforecast;
  List<WeekdayForecast> upcomingForecast;

  Weather({@required this.id, @required this.title, @required this.countryCode, this.temp, this.status}){
    this.stats = {};
    this.todayforecast = [];
    this.upcomingForecast = [];
  }

  void addWeekdayForecast(int weekday, int timeStamp, WeatherStatus status, int temp){
    List<WeekdayForecast> filtered = upcomingForecast.where((entry) => entry.getWeekday == weekday).toList();
    if(filtered.length >= 1){
      filtered[0].temps.add(temp);
      return;
    }
    upcomingForecast.add(WeekdayForecast(weekday, timeStamp, status));
  }

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
