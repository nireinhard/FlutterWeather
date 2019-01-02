import 'dart:core';

class Converter{

  static int k2CelsiusRounded(k){
    num kelvin = k;
    num celsius = kelvin - 273;
    return celsius.toInt();
  }

  static String k2Celsius(k){
    num kelvin = k;
    num celsius = kelvin - 273.0;
    return "${celsius.toInt()} °C";
  }

  static String k2Fahrenheit(){
    // tbd
    return "";
  }

  static String timeStamp2Readable(int timestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
    var minutes = date.minute < 10 ? "0${date.minute}" : date.minute;
    return "${date.hour}:${minutes}";
  }
}