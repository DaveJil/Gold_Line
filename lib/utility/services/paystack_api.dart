import 'dart:convert';

import 'package:gold_line/utility/api_keys.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class CallPayStackApi {
  final String _url = 'https://api.paystack.co/';

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
    var res =
        await http.patch(Uri.parse(fullUrl), headers: await _setHeaders());
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

  // _setHeaders() => {
  //   'Content-type': 'application/json',
  //   'Accept': 'application/json',

  // };

  Future<Map<String, String>> _setHeaders() async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $paystackSecretKey'
    };
    return headers;
  }

  // DIO methods

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
