import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:tuple/tuple.dart';

class WeatherPage extends StatelessWidget {
  Weather _weather;

  WeatherPage(this._weather);

  Tuple2<Color, DecorationImage> _getColorAndImage() {
    if (_weather.status == WeatherStatus.SUNNY) {
      return Tuple2(Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5), DecorationImage(
              image: AssetImage('assets/sunny.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.white30, BlendMode.lighten)
            ));
    } else if (_weather.status == WeatherStatus.CLOUDY) {
      return Tuple2(Colors.black87, DecorationImage(
              image: AssetImage('assets/cloudy.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken)
            ));
    } else {
      // TODO
      return Tuple2(Colors.black87, DecorationImage(
              image: AssetImage('assets/sunny.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken)
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _getColorAndImage().item1,
        title: Text(_weather.title),
      ),
      body: SingleChildScrollView(
        physics: new ClampingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: _getColorAndImage().item2,
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
                          'assets/sun.png',
                          height: 128.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40.0),
                    child: Center(
                      child: Text(
                        '18°',
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
                child: Text('Heute',
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
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text('Jetzt',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Image.asset(
                          'assets/sun.png',
                          height: 35.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text('18°',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text('17:00',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Image.asset(
                          'assets/sun.png',
                          height: 35.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text('15°',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text('18:00',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Image.asset(
                          'assets/sun.png',
                          height: 35.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text('13°',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text('Montag',
                                      style: TextStyle(fontSize: 15)),
                                  flex: 8),
                              Expanded(
                                  child:
                                      Image.asset('assets/sun.png', height: 20),
                                  flex: 5),
                              Expanded(
                                  child:
                                      Text('3', style: TextStyle(fontSize: 15)),
                                  flex: 1),
                              Expanded(
                                  child: Text('-1',
                                      style: TextStyle(fontSize: 15)),
                                  flex: 1),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text('Dienstag',
                                      style: TextStyle(fontSize: 15)),
                                  flex: 8),
                              Expanded(
                                  child:
                                      Image.asset('assets/sun.png', height: 20),
                                  flex: 5),
                              Expanded(
                                  child:
                                      Text('3', style: TextStyle(fontSize: 15)),
                                  flex: 1),
                              Expanded(
                                  child: Text('-1',
                                      style: TextStyle(fontSize: 15)),
                                  flex: 1),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text('Mittwoch',
                                      style: TextStyle(fontSize: 15)),
                                  flex: 8),
                              Expanded(
                                  child:
                                      Image.asset('assets/sun.png', height: 20),
                                  flex: 5),
                              Expanded(
                                  child:
                                      Text('3', style: TextStyle(fontSize: 15)),
                                  flex: 1),
                              Expanded(
                                  child: Text('-1',
                                      style: TextStyle(fontSize: 15)),
                                  flex: 1),
                            ],
                          ))
                    ],
                  )),
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
                              Text('Sonnenaufgang'),
                              Text('6:30', style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Sonnenuntergang'),
                              Text('18:30', style: TextStyle(fontSize: 20.0)),
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
                              Text('Schnee'),
                              Text('0%', style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Feuchtigkeit'),
                              Text('95%', style: TextStyle(fontSize: 20.0)),
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
                              Text('Niederschlag'),
                              Text('0 mm', style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Luftdruck'),
                              Text('1033 hPa',
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
                              Text('Luftqualitätsindex'),
                              Text('25', style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Luftqualität'),
                              Text('Gut', style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          flex: 1),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
