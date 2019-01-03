import 'package:http/http.dart' as http;
import 'package:room_display/models/mainDisplayInfo.dart';
import 'dart:convert';

class RestAPIClient {
  String url = "http://172.16.21.37:8089/api/room";

  Map<String, String> _getHeaders() {
    var result = new Map<String, String>();
    result.addAll({"Content-Type": "application/json"});
    return result;
  }

  Future<MainDisplayInfo> getData() async {
    var response = await http.get(url, headers: _getHeaders());
    if (response.statusCode != 200) return null;
    return MainDisplayInfo.fromJson(jsonDecode(response.body));
  }
}
