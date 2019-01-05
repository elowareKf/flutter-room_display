import 'package:http/http.dart' as http;
import 'package:room_display/models/mainDisplayInfo.dart';
import 'dart:convert';

class RestAPIClient {
  String url = "http://vandros:8085/api/room";

  Map<String, String> _getHeaders() {
    var result = new Map<String, String>();
    result.addAll({"Content-Type": "application/json"});
    return result;
  }

  Future<MainDisplayInfo> getData(roomName) async {
    var response = await http.get(url + "/"+roomName, headers: _getHeaders());
    if (response.statusCode != 200) return null;
    var data = MainDisplayInfo.fromJson(jsonDecode(response.body));
    data.roomName = roomName;
    return data;
  }
}
