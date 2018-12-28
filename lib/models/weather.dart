import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherStatus{
  SUNNY, CLOUDY, RAINY
}

@JsonSerializable()
class Weather {
  final int id;
  final String title;
  final String countryCode;
  final String temp;
  final WeatherStatus status;

  Weather({@required this.id, @required this.title, @required this.countryCode, this.temp, this.status});

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
