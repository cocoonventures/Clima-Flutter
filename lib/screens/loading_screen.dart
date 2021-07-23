import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:pretty_json/pretty_json.dart';
import '/services/open_weather.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location _loc = Location();
  Map<String, dynamic> _weather = Map();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    await _loc.getCurrentLocation();
  }

  Future<void> getWeather() async {
    var data = await OpenWeather.getData(
        {'lat': _loc.latitude.toString(), 'lon': _loc.longitude.toString()});

    _weather = data['weather'][0];
    print("data JSON object");
    printPrettyJson(data);
    print("weather");
    printPrettyJson(_weather);
  }

  @override
  Widget build(BuildContext context) {
    getWeather();
    return Scaffold(
      body: Center(
        child: Text('BIGbrother sees you at ${_loc.position()}'),
      ),
    );
  }
}
