import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:gold_line/screens/payment_screen/payment_details.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/helpers/custom_display_widget.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/transaction/transactions.dart';
import '../../screens/map/map_widget.dart';
import '../api.dart';
import 'map_provider.dart';

Transactions? transactions = Transactions();
// Future getTransactionHistory(BuildContext context) async {
//   try {
//     Future<String> getToken() async {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       var token = localStorage.getString('token');
//       print('The token is $token');
//       return token ?? '';
//     }
//
//     Future<Map<String, String>> setHeaders() async => {
//           'Content-type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${await getToken()} '
//         };
//     var res = await http.get(
//         Uri.parse("https://goldline.herokuapp.com/api/wallet/transactions"),
//         headers: await setHeaders());
//     print(res);
//     var data = json.decode(res.body);
//     final result = data.map((e) => Transactions.fromJson(e)).toList();
//
//     print(data);
//
//     List processResponse(http.Response response) {
//       var data = json.decode(response.body);
//       switch (response.statusCode) {
//         case 200:
//           return data;
//         case 409:
//           throw AppException(message: '${data['message']}');
//         case 412:
//           throw AppException(message: '${data['message']}');
//         default:
//           return data;
//       }
//     }
//
//     print(res);
//     var response = processResponse(res);
//     print(response);
//
//     print(transactions);
//     return result;
//   } on SocketException {
//     throw const SocketException('No internet connection');
//   } catch (err) {
//     throw Exception(err.toString());
//   }
// }

Future getTransactionHistory() async {
  var response = await CallApi().getData('wallet/transactions');
  print(response);
  final result = response["data"];
  final data = result.map((e) => Transactions.fromJson(e)).toList();
  print("dat = $data");
  return data;
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

Future deposit(String amount, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();


  Map<String, dynamic> request = {

    'amount': amount,
  };

  try {
    var response = await CallApi().postData(request, 'wallet/deposit');
    print(response);
    String code = response['code'];
    if (code == "success") {
      changeScreenReplacement(context, WalletScreen());
    }
    else{
      String message = response['message'];
      {
        CustomDisplayWidget.displaySnackBar(context, message);
        changeScreenReplacement(context, PaymentDetails());
      }
    }
  } on SocketException {
    throw const SocketException('No internet connection');
  } catch (err) {
    throw Exception(err.toString());
  }
}

Future withdraw(String amount, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();


  Map<String, dynamic> request = {

    'amount': amount,
  };

  try {
    var response = await CallApi().postData(request, 'wallet/withdraw');
    print(response);
    String code = response['code'];
    String message = response['message'];

    if (code == "success") {
      CustomDisplayWidget.displaySnackBar(context, message);

      changeScreenReplacement(context, WalletScreen());
    }
    else{
      String message = response['message'];
      String code = response['code'];
      {
        CustomDisplayWidget.displaySnackBar(context, message);

      if(code == "bank-not-found"
      )
      {
        await CustomDisplayWidget.displaySnackBar(context, message);

        changeScreenReplacement(context, PaymentDetails());
      }
      }


    }
  } on SocketException {
    throw const SocketException('No internet connection');
  } catch (err) {
    throw Exception(err.toString());
  }
}

Future makeCardPayment(String? amount, BuildContext context) async {
  final MapProvider mapProvider =
  Provider.of<MapProvider>(context, listen: false);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? email = preferences.getString("email");
  int randomInt = Random().nextInt(100);
  var uuid = Uuid();
  var refId = uuid.v4();



  final Customer customer = Customer(
      name: "user$randomInt", phoneNumber: "09$randomInt$randomInt$randomInt", email: email?? "user$randomInt@gmail.com");

  final flutterwave = Flutterwave(
      context: context,
      publicKey: "FLWPUBK-fdc22eaae2024e22b7a5e34ca810bf9a-X",
      currency: "NGN",
      amount: amount!,
      txRef: refId,
      customer: customer,
      paymentOptions: "card, account, transfer",
      customization: Customization(),
      redirectUrl: 'www.google.com',
      isTestMode: false);

  final ChargeResponse flutterwaveResponse = await flutterwave.charge();
  bool success = flutterwaveResponse.success!;
  print(flutterwaveResponse);
  if (success == true) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String message = flutterwaveResponse.status!;
    print(flutterwaveResponse);

    print(message);
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "Transaction successful",
        message: "Your rider would be at pickup location in a moment",
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

   await makeCardPayment(amount, context);

  } else {
    print(flutterwaveResponse);

    String message = flutterwaveResponse.status!;
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "Transaction unsuccessful",
        message: message,
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Transaction Failed Try Again"),
      backgroundColor: Colors.redAccent,
    ));
  }
}



