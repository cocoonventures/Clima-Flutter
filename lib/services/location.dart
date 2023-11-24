import 'package:geolocator/geolocator.dart';

class Location {
  Position? _pos;
  double? latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

      _pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print('Location::getCurrentLocation > $e');
    }
    latitude = _pos?.latitude ?? 0;
    longitude = _pos?.longitude ?? 0;
    printLocation();
  }

  String position() {
    return "lat[${latitude ?? 'nowhere'}] and long[${longitude ?? 'somewhere'}]";
  }

  void printLocation() {
    print('BIGbrother sees you at: ${position()}');
  }
}
