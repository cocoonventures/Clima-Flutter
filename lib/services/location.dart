import 'package:geolocator/geolocator.dart';

class Location {
  Position _pos;
  double latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      _pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = _pos.latitude;
      longitude = _pos.longitude;
    } catch (e) {
      print('Location::getCurrentLocation > $e');
    }
    printLocation();
  }

  String position() {
    return "lat[${latitude ?? 'nowhere'}] and long[${longitude ?? 'somewhere'}]";
  }

  void printLocation() {
    print('BIGbrother sees you at: ${position()}');
  }
}
