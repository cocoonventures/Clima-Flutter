import 'package:clima/services/location.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:clima/services/open_weather.dart';
// import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class Weather {
  Weather(Map<String, dynamic> weather) {
    temp = weather['temp'];
    main = weather['main'];
    desc = weather['description'];
    icon = weather['icon'];
    feelLike = weather['feels_like'];
    low = weather['temp_min'];
    high = weather['temp_max'];
    condition = weather['condition'];
    pressure = weather['pressure'];
    humidity = weather['humidity'];
    seaLevel = weather['sea_level'];
    groundLevel = weather['grnd_level'];
    city = weather['city_name'];
    weatherMsg = weather['weather_msg'];
  }

  late double temp;
  late String main;
  late String desc;
  late String icon;
  late double feelLike;
  late double low;
  late double high;
  late int condition;
  late int pressure;
  late int humidity;
  late int? seaLevel;
  late int? groundLevel;
  late String city;
  late String weatherMsg;
}

class WeatherModel {
  Location _loc = Location();
  Map<String, dynamic> _weather = Map();
  String? _cityName;

  Future<Weather> getLocationWeather({int retries = 0}) async {
    await _loc.getCurrentLocation();
    return getWeather();
  }

  Future<Weather> getWeather() async {
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
    _weather['icon'] = getWeatherIcon(_weather['condition']);
    _weather['weather_msg'] = getMessage(_weather['temp'].toInt());

    print("The weather in $_cityName is:");
    printPrettyJson(_weather);
    return Weather(_weather);
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

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 75) {
      return 'It\'s 🍦 time';
    } else if (temp > 70) {
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥just in case';
    }
  }
}
