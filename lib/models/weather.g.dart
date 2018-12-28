// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
      id: json['id'] as int,
      title: json['title'] as String,
      countryCode: json['countryCode'] as String,
      temp: json['temp'] as String,
      status: _$enumDecodeNullable(_$WeatherStatusEnumMap, json['status']));
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'countryCode': instance.countryCode,
      'temp': instance.temp,
      'status': _$WeatherStatusEnumMap[instance.status]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$WeatherStatusEnumMap = <WeatherStatus, dynamic>{
  WeatherStatus.SUNNY: 'SUNNY',
  WeatherStatus.CLOUDY: 'CLOUDY',
  WeatherStatus.RAINY: 'RAINY'
};
