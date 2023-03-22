import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'https://goldline.herokuapp.com/api/';
  final String _urlTry = 'https://areaconnect.com.ng/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http
        .post(Uri.parse(fullUrl),
            body: jsonEncode(data), headers: await _setHeaders())
        .timeout(const Duration(
          seconds: 40,
        ));
    return _processResponse(res);
  }

  postTryData(data, apiUrl) async {
    var fullUrl = _urlTry + apiUrl;
    var res = await http
        .post(Uri.parse(fullUrl),
            body: jsonEncode(data), headers: await _setHeaders())
        .timeout(const Duration(
          seconds: 40,
        ));
    return _processResponse(res);
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http
        .get(Uri.parse(fullUrl), headers: await _setHeaders())
        .timeout(const Duration(
          seconds: 40,
        ));
    return _processResponse(res);
  }

  updateData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http
        .put(Uri.parse(fullUrl), headers: await _setHeaders())
        .timeout(const Duration(
          seconds: 40,
        ));
    return _processResponse(res);
  }

  patchData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http
        .patch(Uri.parse(fullUrl), headers: await _setHeaders())
        .timeout(const Duration(
          seconds: 40,
        ));
    return _processResponse(res);
  }

  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http
        .delete(Uri.parse(fullUrl), headers: await _setHeaders())
        .timeout(const Duration(
          seconds: 40,
        ));
    return _processResponse(res);
  }

  Future addImage(data, apiUrl, dynamic filepath, dynamic image) async {
    var fullUrl = _url + apiUrl;

    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      // ..fields.addAll(data)
      ..headers.addAll(await _setPictureHeaders())
      ..files.add(
          http.MultipartFile.fromBytes('avatar', image, filename: filepath));
    print("filepath = $filepath");
    var streamedResponse = await request.send();
    print("streamedresponse =  $streamedResponse");
    var response = await http.Response.fromStream(streamedResponse);
    print("response = $response");
    var result = jsonDecode(response.body);
    print("result = $result");

    if (response.statusCode == 201) {
      return result;
    } else {}
  }

  Future<Map<String, String>> _setPictureHeaders() async => {
        'Content-type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer ${await _getToken()} '
      };

  // _setHeaders() => {
  //   'Content-type': 'application/json',
  //   'Accept': 'application/json',

  // };
  Future<Map<String, String>> _setHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await _getToken()} '
      };

  Future<String> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print('The token is $token');
    return token ?? '';
  }

  // // DIO methods
  // dioPost(data, apiUrl) async {
  //   var fullUrl = _url + apiUrl;
  //   return await Dio().post(
  //     fullUrl,
  //     data: data,
  //     options: Options(headers: await _setHeaders()),
  //   );
  // }

  Map<String, dynamic> _processResponse(http.Response response) {
    var data = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return data;
      case 409:
        throw AppException(message: '${data['message']}');
      case 412:
        throw AppException(message: '${data['message']}');
      default:
        return data;
    }
  }
}

class AppException implements Exception {
  final String message;
  AppException({required this.message});

  @override
  String toString() {
    return message;
  }
}
