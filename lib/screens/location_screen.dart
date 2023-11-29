import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  late double temp;
  late String main;
  late String desc;
  late String icon;
  late double feels_like;
  late double low;
  late double high;
  late int condition;
  late int pressure;
  late int humidity;
  late int? sea_level;
  late int? grnd_level;
  late String city;

  late String weatherMsg;

  @override
  void initState() {
    print("[Inside LocationScreenState]");
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weather) {
    setState(() {
      temp = weather['temp'];
      main = weather['main'];
      desc = weather['description'];
      icon = weather['icon'];
      feels_like = weather['feels_like'];
      low = weather['temp_min'];
      high = weather['temp_max'];
      condition = weather['condition'];
      pressure = weather['pressure'];
      humidity = weather['humidity'];
      sea_level = weather['sea_level'];
      grnd_level = weather['grnd_level'];
      city = weather['city_name'];
      weatherMsg = weatherModel.getMessage(temp.toInt());
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
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weatherModel.getWeatherIcon(condition)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
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
