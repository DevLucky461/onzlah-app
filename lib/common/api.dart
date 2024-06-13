import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

class CallApi {
  postData(data, apiUrl) async {
    var fullUrl = Common.ApiUrl + apiUrl + await _getToken();
    print(fullUrl);
    if (data != null) print(data);
    var response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    print(response.body.toString());
    return response;
  }

  multipartPostData(data, File image, apiUrl) async {
    var fullUrl = Common.ApiUrl + apiUrl + await _getToken();
    print(fullUrl);
    if (data != null) print(data);
    var uri = Uri.parse(fullUrl);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(_setHeaders())
      ..fields.addAll(data)
      ..files.add(http.MultipartFile(
          'profile-image', image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body.toString());
    return response;
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
