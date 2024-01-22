import 'dart:convert';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class ServerHelper {
  static Future<dynamic> post(url, data) async {
    var token = await PrefManager.getToken();
    Map sendData = {};
    if (data?.isNotEmpty ?? false) {
      sendData.addAll(data);
    }

    var body = json.encode(sendData);
    var response = await http.post(
      Uri.parse(WebClient.ip + url),
      headers: {"Content-Type": "application/json", "token": token ?? ""},
      body: body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      var error = {
        "status": false,
        "msg": "Invalid Request",
      };
      return error;
    }
  }

  static Future<dynamic> get(url) async {
    try {
      var token = await PrefManager.getToken();
      var response = await http.get(
        Uri.parse(WebClient.ip + url),
        headers: {"Content-Type": "application/json", "token": token ?? ""},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        var error = {
          "status": false,
          "msg": "Invalid Request",
        };
        return error;
      }
    } on Exception catch (e) {
      print("Exception -- " + e.toString());
    }
  }
}
