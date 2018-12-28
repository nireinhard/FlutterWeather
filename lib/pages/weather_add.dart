import 'package:flutter/material.dart';
import 'package:weather/widgets/weather_add/search_result.dart';
import 'package:weather/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/models/weather.dart';

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

  void _initDb() async {
    _db = await AssetDatabase.prepareDB();
  }

  Future<List<Map>> getSearchResults(String city) async {
    return await _db
        .rawQuery('Select * from cities where name like "%${city}%"');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  searchResults = [];
                }
                setState(() {
                  List<Weather> results = [];
                  getSearchResults(value).then((value) {
                    value.forEach((result) {
                      if (results.length <= 10) {
                        results.add(Weather(
                          id: result['id'],
                          title: result['name'],
                          countryCode: result['country'],
                        ));
                      }
                    });
                    searchResults = results;
                  });
                });
              },
              decoration: InputDecoration(labelText: 'Type Location'),
            ),
            Container(
              height: 500,
              margin: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(child: SearchResult(searchResults[index]));
                },
                itemCount: searchResults.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
