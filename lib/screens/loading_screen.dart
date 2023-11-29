import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:clima/services/open_weather.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location _loc = Location();
  Map<String, dynamic> _weather = Map();
  String? _cityName;

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  void getLocationWeather({int retries = 0}) async {
    await _loc.getCurrentLocation();
    getWeather();
  }

  Future<void> getWeather() async {
    Map<String, dynamic> data = await OpenWeather.getData(
        {'lat': _loc.latitude.toString(), 'lon': _loc.longitude.toString()});

    printPrettyJson(data);
    _weather.clear();
    _weather
      ..addAll(data['weather'][0])
      ..addAll(data['main']);
    _weather['city_name'] = data['name']; // ..addEntries(data['name']);
    fTemps();
    _cityName = data['name'];
    _weather['condition'] = _weather['id'];

    print("The weather in $_cityName is:");
    printPrettyJson(_weather);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: _weather,
      );
    }));
  }

  // Convert all K to F
  void fTemps() {
    _weather['temp'] = k2f(_weather['temp'].toDouble());
    _weather['feels_like'] = k2f(_weather['feels_like'].toDouble());
    _weather['temp_min'] = k2f(_weather['temp_min'].toDouble());
    _weather['temp_max'] = k2f(_weather['temp_max'].toDouble());
  }

  // Convert a single double K to F
  double k2f(double k) {
    double f = k - 273.15;
    f *= 9 / 5;
    f += 32;
    return roundDouble(f, 1);
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places) as double;
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(
          color: Colors.orange[300]!,
          size: 100.0,
          waveColor: (Colors.amberAccent)!,
        ),
        // Text('BIGbrother sees you at ${_loc.position()}'),
      ),
    );
  }
}
