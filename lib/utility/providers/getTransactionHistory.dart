import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/transaction/transactions.dart';
import '../api.dart';

Transactions? transactions = Transactions();
Future getTransactionHistory(BuildContext context) async {
  try {
    Future<String> getToken() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      print('The token is $token');
      return token ?? '';
    }

    Future<Map<String, String>> setHeaders() async => {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await getToken()} '
        };
    var res = await http.get(
        Uri.parse("https://goldline.herokuapp.com/api/wallet/transactions"),
        headers: await setHeaders());
    print(res);
    var data = json.decode(res.body);
    final result = data.map((e) => Transactions.fromJson(e)).toList();

    print(data);

    List processResponse(http.Response response) {
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

    print(res);
    var response = processResponse(res);
    print(response);

    print(transactions);
    return result;
  } on SocketException {
    throw const SocketException('No internet connection');
  } catch (err) {
    throw Exception(err.toString());
  }
}

Future getWalletBalance(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  Map<String, dynamic> request = {
    'cash_status': "paid",
  };

  try {
    var response = await CallApi().getData('wallet/info');
    print(response);
    String code = response['code'];
    String balance = response['data']['balance'];
    if (code == "success") {
      print(balance);
      return balance;
    }
  } on SocketException {
    throw const SocketException('No internet connection');
  } catch (err) {
    throw Exception(err.toString());
  }
}
