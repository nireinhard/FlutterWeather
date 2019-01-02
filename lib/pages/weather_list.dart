import 'package:flutter/material.dart';
import 'package:weather/widgets/weather_list/weather_preview.dart';
import './weather.dart';
import './weather_add.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather/scoped-models/weather_model.dart';

class WeatherList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherListState();
  }
}

class _WeatherListState extends State<WeatherList> {
  void initState() {
    super.initState();
    WeatherModel model = ScopedModel.of(context);
    model.loadWeatherList();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WeatherModel>(
      builder: (BuildContext context, Widget child, WeatherModel model) {
        return Scaffold(
          appBar: AppBar(title: Text('Weather')),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 4.0,
            icon: const Icon(Icons.add),
            label: const Text('Add'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return WeatherAddPage();
                }),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: RefreshIndicator(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black87, BlendMode.darken)),
              ),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Remove',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        )),
                    key: Key(model.weatherList[index].title),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.endToStart) {
                        model.removeWeather(index);
                      }
                    },
                    child: GestureDetector(
                      child: WeatherPreview(
                        model.weatherList[index],
                      ),
                      onTap: () async {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return WeatherPage(model.weatherList[index]);
                        }));
                      },
                    ),
                  );
                },
                itemCount: model.weatherList.length,
              ),
            ),
            onRefresh: model.refreshWeatherList,
          ),
        );
      },
    );
  }
}
