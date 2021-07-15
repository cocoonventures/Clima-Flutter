import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Position _pos;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    _pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    printLocation();
  }

  void printLocation() {
    print('BIGbrother sees you at $_pos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('BIGbrother sees you at $_pos'),
      ),
    );
  }
}
