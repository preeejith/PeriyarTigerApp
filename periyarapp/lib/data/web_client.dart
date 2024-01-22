import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:parambikulam/utils/pref_manager.dart';

///New
class WebClient {
  WebClient();
  // static final ip = "https://test.parambikulam.org";
  // static final imageIp = "https://test.parambikulam.org/u/";
  //  static final liveIp = "https://test.parambikulam.org";
  // static final ip = "https://api.parambikulam.org";
  // static final imageIp = "https://api.parambikulam.org/u/";
  // static final liveIp = "https://api.parambikulam.org";
  // static final ip = "http://192.168.49.45:4000";
  // static final imageIp = "https://api.parambikulam.org/u/";

  // static final imageIp = "http://13.126.157.44/u/";
  // static final ip = "http://192.168.53.87:4000";
  // static final ip = "http://192.168.53.97:2000";
  // static final imageIp = "http://192.168.53.97:2000/u/";

  ///org
  // static final ip = "https://api.parambikulam.org";
  // static final liveIp = "https://api.parambikulam.org";
  // static final imageIp = "https://api.parambikulam.org/u/";
//jikku
  // static final ip = "http://192.168.52.74:4300";
  // static final imageIp = "http://192.168.52.74:4300/u/";
  // static final liveIp = "http://192.168.52.74:4300";

  //ajo
  static final ip = "http://172.20.10.3:4300";
  static final imageIp = "http://172.20.10.3:4300/u/";
  static final liveIp = "http://172.20.10.3:4300";

  static Future<dynamic> post(url, data) async {
    var token = await PrefManager.getToken();
    log(url.toString());
    print(token);
    Map sendData = {};
    if (data?.isNotEmpty ?? false) {
      sendData.addAll(data);
    }

    var body = json.encode(sendData);
    print(token);
    var response = await http.post(
      Uri.parse(ip + url),
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
    var token = await PrefManager.getToken();
    log(url.toString());
    print(token);
    var response = await http.get(
      Uri.parse(ip + url),
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive",
        "token": token ?? ""
      },
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

  static Future<dynamic> files(
      String url, String _image, String _coverimage, String id) async {
    var request = http.MultipartRequest('POST', Uri.parse(ip + url));
    String token = await PrefManager.getToken();

    request.headers
        .addAll({'Content-Type': 'application/form-data', 'token': token});
    if (_image.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
          'images', File(_image).readAsBytesSync(),
          filename: _image.split('/').last));
      if (_coverimage.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
            'coverphoto', File(_coverimage).readAsBytesSync(),
            filename: _image.split('/').last));
      }

      request.fields['id'] = id;
    }
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (json.decode(response.body)['status']) {
        return jsonDecode(response.body);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<dynamic> commonFilesUpload(String url, String _image, String id,
      String variable, String requestvariable) async {
    var request = http.MultipartRequest('POST', Uri.parse(ip + url));
    String token = await PrefManager.getToken();

    request.headers
        .addAll({'Content-Type': 'application/form-data', 'token': token});
    if (_image.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
          variable, File(_image).readAsBytesSync(),
          filename: _image.split('/').last));
      request.fields[requestvariable] = id;
    }
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.body);
      if (json.decode(response.body)['status']) {
        return jsonDecode(response.body);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<dynamic> files3(String url, String _image, String id) async {
    var request = http.MultipartRequest('POST', Uri.parse(ip + url));
    String token = await PrefManager.getToken();

    request.headers
        .addAll({'Content-Type': 'application/form-data', 'token': token});
    if (_image.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
          'coverphoto', File(_image).readAsBytesSync(),
          filename: _image.split('/').last));

      request.fields['id'] = id;
    }
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (json.decode(response.body)['status']) {
        return jsonDecode(response.body);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<dynamic> postImage(url) async {}
}
