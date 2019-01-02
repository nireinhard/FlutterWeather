import 'package:weather/models/weather.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

class WeatherUtility {
  static WeatherStatus parseWeatherStatusCode(int code) {
    String codeString = '$code';
    if (codeString.startsWith('2')) {
      return WeatherStatus.STORMY;
    } else if (codeString.startsWith('3') || codeString.startsWith('5')) {
      return WeatherStatus.RAINY;
    } else if (codeString.startsWith('6')) {
      return WeatherStatus.SNOWY;
    } else if (codeString.startsWith('8')) {
      if (codeString.endsWith('0')) {
        return WeatherStatus.SUNNY;
      }
      return WeatherStatus.CLOUDY;
    } else {
      return WeatherStatus.CLOUDY;
    }
  }

  static String getNameForWeekday(int weekday) {
    switch (weekday) {
      case 1:
      return 'Monday';
      case 2:
      return 'Tuesday';
      case 3:
      return 'Wednesday';
      case 4:
      return 'Thursday';
      case 5:
      return 'Friday';
      case 6:
      return 'Saturday';
      case 7:
      return 'Sunday';
      default:
        return '';
    }
  }

  static Tuple2<Color, DecorationImage> getBackgroundTheme(
      int sunsetTimestamp, WeatherStatus status) {
    bool isNightTime = _isNightTime(sunsetTimestamp);
    Color backgroundColor =
        isNightTime ? Colors.black87 : Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5);
    String backgroundImageAsset = _getBackgroundImageAssetPath(status);

    DecorationImage backgroundImage = DecorationImage(
        image: AssetImage(backgroundImageAsset),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(backgroundColor,
            isNightTime ? BlendMode.darken : BlendMode.lighten));
    return Tuple2(backgroundColor, backgroundImage);
  }

  static String getWeatherIconAsset(WeatherStatus status) {
    switch (status) {
      case WeatherStatus.SUNNY:
        return 'assets/sun.png';
      case WeatherStatus.RAINY:
        return 'assets/rain.png';
      case WeatherStatus.CLOUDY:
        return 'assets/cloud.png';
      case WeatherStatus.STORMY:
        return 'assets/storm.png';
      case WeatherStatus.SNOWY:
        return 'assets/snow.png';
      default:
        return 'assets/sun.png';
    }
  }

  static bool _isNightTime(int timeStamp) {
    // todo: implement a proper check
    return DateTime.now().hour >= 20 || DateTime.now().hour <= 6;
  }

  static String _getBackgroundImageAssetPath(WeatherStatus status) {
    switch (status) {
      case WeatherStatus.SUNNY:
        return 'assets/sunny.jpg';
      case WeatherStatus.RAINY:
        return 'assets/rainy.jpg';
      case WeatherStatus.CLOUDY:
        return 'assets/cloudy.jpg';
      case WeatherStatus.STORMY:
        return 'assets/stormy.jpg';
      case WeatherStatus.SNOWY:
        return 'assets/snowy.jpg';
      default:
        return 'assets/sunny.jpg';
    }
  }
}
