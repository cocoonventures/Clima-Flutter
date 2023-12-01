import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:pretty_json/pretty_json.dart';
import 'dart:core';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});

  final Weather locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // WeatherModel weatherModel = WeatherModel();

  late double temp;
  late String main;
  late String desc;
  late String icon;
  late String city;
  late int condition;
  late String weatherMsg;

  @override
  void initState() {
    print("[Inside LocationScreenState]");
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(Weather weather) {
    print("[Inside updateUI]");
    // printPrettyJson(weather);
    setState(() {
      temp = weather.temp;
      main = weather.main;
      desc = weather.desc;
      icon = weather.icon;
      city = weather.city;
      condition = weather.condition;
      weatherMsg = weather.weatherMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${temp.toInt()}°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          '$icon',
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
