 import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkNinja {
  NetworkNinja(this.url);
  final String url;

  Future<Map<String, dynamic>> getData() async {
    Uri uri = Uri.parse(url);
    print('getData: attempting url: $url');

    http.Response? response;
    try {
      response = await http.get(uri);
    } catch (e) {
      print("Problem reaching $url");
      print('Error: $e');
    }

    if (response?.statusCode == 200) {
      return jsonDecode(response?.body ?? "") ?? {};
    } else {
      print('Status not OK. Code[${response?.statusCode}]');
      return {};
    }
  }
}
