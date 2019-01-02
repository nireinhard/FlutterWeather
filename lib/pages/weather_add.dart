import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:weather/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/models/weather.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather/scoped-models/weather_model.dart';

class WeatherAddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherAddPageState();
  }
}

class _WeatherAddPageState extends State<WeatherAddPage> {
  List<Weather> searchResults = [];
  Database _db;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  @override
    void dispose() {
      super.dispose();
      _db.close();
      print('closed db');
    }

  void _initDb() async {
    _db = await AssetDatabase.prepareDB();
  }

  Future<List<Map>> getSearchResults(String city) async {
    var results= await _db
        .rawQuery('Select * from cities where name like "%${city}%"');
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WeatherModel>(
        builder: (BuildContext context, Widget child, WeatherModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Location'),
        ),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: MaterialSearch<dynamic>(
              placeholder: 'Type location',
              getResults: (String criteria) async {
                if (criteria.trim().isEmpty) {
                  return [];
                }
                var list = await getSearchResults(criteria);
                return list
                    .map((entry) => new MaterialSearchResult<dynamic>(
                          value: entry, //The value must be of type <String>
                          text:
                              "${entry['name']}, ${entry['country']}", //String that will be show in the list
                          icon: Icons.location_on,
                        ))
                    .toList();
              },
              onSelect: (map) {
                model.addWeather(Weather(
                    id: map['id'],
                    title: map['name'],
                    countryCode: map['country']));
                Navigator.of(context).pop();
              },
            )),
      );
    });
  }
}
