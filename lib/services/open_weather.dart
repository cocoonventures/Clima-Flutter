import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeather {
  static const String API_KEY = 'bc586d3fb9f5fd7842b98e82f6d8da74';
  static const Map<String, String> api_url = {
    'geo':
        'https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}',
  };

  static Future<Map<String, dynamic>> getData(Map<String, String> hash) async {
    String url = getURL(type: 'geo', hash: hash);
    Uri uri = Uri.parse(url);
    print('getData: attempting url: $url');

    http.Response response = await http.get(uri);
    return jsonDecode(response.body);
  }

  static String getURL({String type = 'geo', Map<String, String> hash}) {
    String url = api_url[type];

    url = url.replaceAll('{API key}', API_KEY);
    hash.forEach((key, value) {
      url = url.replaceAll('\{$key\}', value);
    });
    return url;
  }
}
