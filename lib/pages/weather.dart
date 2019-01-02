import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:tuple/tuple.dart';
import 'package:weather/widgets/utility/weather.dart';

class WeatherPage extends StatefulWidget {
  Weather _weather;

  WeatherPage(this._weather);

  @override
  State<StatefulWidget> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildForecastWidget() {
    List<Widget> forecastList = [];
    widget._weather.todayforecast.forEach((forecast) {
      var listElement = Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text("${forecast.getTimeStamp}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
          Image.asset(
            WeatherUtility.getWeatherIconAsset(forecast.status),
            height: 35.0,
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text("${forecast.temp}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
        ],
      );
      forecastList.add(listElement);
    });
    return forecastList;
  }

  List<Widget> _buildWeekdayForecastWidget() {
    List<Widget> weekdayForecastList = [];
    widget._weather.upcomingForecast.forEach((forecast) {
      var listElement = Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                      WeatherUtility.getNameForWeekday(forecast.getWeekday),
                      style: TextStyle(fontSize: 15)),
                  flex: 8),
              Expanded(
                  child: Image.asset(
                      WeatherUtility.getWeatherIconAsset(forecast.status),
                      height: 20),
                  flex: 5),
              Expanded(
                  child: Text("${forecast.maxTemp}", style: TextStyle(fontSize: 15)), flex: 1),
              Expanded(
                  child: Text("${forecast.minTemp}", style: TextStyle(fontSize: 15)), flex: 1),
            ],
          ));
      weekdayForecastList.add(listElement);
    });
    return weekdayForecastList;
  }

  @override
  Widget build(BuildContext context) {
    int sunsetTimestamp = widget._weather.stats['sunsettimestamp'];
    Tuple2<Color, DecorationImage> theme = WeatherUtility.getBackgroundTheme(
        sunsetTimestamp, widget._weather.status);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.item1,
        title: Text(widget._weather.title),
      ),
      body: SingleChildScrollView(
        physics: new ClampingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: theme.item2,
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: Image.asset(
                          WeatherUtility.getWeatherIconAsset(
                              widget._weather.status),
                          height: 128.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40.0),
                    child: Center(
                      child: Text(
                        "${widget._weather.temp}",
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                child: Text('Today',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.white10,
                    ),
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.white10,
                    ),
                  ),
                ),
                height: 110.0,
                child: ListView(
                  itemExtent: 70.0,
                  padding: EdgeInsets.all(10.0),
                  scrollDirection: Axis.horizontal,
                  children: _buildForecastWidget(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: _buildWeekdayForecastWidget(),
                ),
              ),
              Divider(
                color: Colors.white30,
                height: 1.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Sunrise'),
                              Text("${widget._weather.stats['sunrise']}",
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Sunset'),
                              Text("${widget._weather.stats['sunset']}",
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                    ],
                  ),
                ]),
              ),
              Divider(
                color: Colors.white30,
                height: 1.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Clouds'),
                              Text('${widget._weather.stats['clouds']} %',
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Humidity'),
                              Text("${widget._weather.stats['humidity']}%",
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                    ],
                  ),
                ]),
              ),
              Divider(
                color: Colors.white30,
                height: 1.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Rainfall'),
                              Text('0 mm', style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Pressure'),
                              Text("${widget._weather.stats['pressure']} hPa",
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                    ],
                  ),
                ]),
              ),
              Divider(
                color: Colors.white30,
                height: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
