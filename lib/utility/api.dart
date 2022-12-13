import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'https://goldline.herokuapp.com/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: await _setHeaders());
    return _processResponse(res);
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http.get(Uri.parse(fullUrl), headers: await _setHeaders());
    return _processResponse(res);
  }

  updateData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res = await http.put(Uri.parse(fullUrl), headers: await _setHeaders());
    return _processResponse(res);
  }

  patchData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res =
        await http.patch(Uri.parse(fullUrl), headers: await _setHeaders());
    return _processResponse(res);
  }

  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var res =
        await http.delete(Uri.parse(fullUrl), headers: await _setHeaders());
    return _processResponse(res);
  }

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

  dynamic _processResponse(dynamic response) {
    switch (response.statusCode) {
      case 200:
        var resJson = jsonDecode(response.body);
        print(resJson);
        return resJson;
      case 400:
        throw SocketException(
            // utf8.decode(response.bodyBytes),
            response.request!.url.toString());
      case 401:
      case 402:
      case 403:
      case 404:
        throw Exception(
            // utf8.decode(response.bodyBytes),
            response.request!.url.toString());
      case 500:
      default:
        throw Exception(
            // utf8.decode(response.bodyBytes),
            response.request!.url.toString());
    }
  }
}
