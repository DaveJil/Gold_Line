import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/screens/payment_screen/payment_details.dart';
import 'package:gold_line/screens/profile/wallet/deposit%20screen.dart';
import 'package:gold_line/screens/profile/wallet/paystack_checkout.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/api_keys.dart';
import 'package:gold_line/utility/helpers/custom_display_widget.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/services/paystack_api.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/transaction/transactions.dart';
import '../api.dart';
import 'map_provider.dart';

Transactions? transactions = Transactions();
String? checkOutURL;
String? accessCode;
String? reference;
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

}



Future makePayStackPayment(String? amount,
     BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? email = preferences.getString("email");
  int randomInt = Random().nextInt(1000);

  Charge charge = Charge()
  ..email = email ?? "user$randomInt@gmail.com"
  ..amount = int.parse("${amount}00")
    ..reference = 'GoldLine_${DateTime.now()}'
  ..currency = 'NG';

  CheckoutResponse checkoutResponse = await payStackPlugin.checkout
    (context,
      method: CheckoutMethod.card,
      charge: charge);
  print(checkoutResponse);

  if (checkoutResponse.status == true) {
    String message  = checkoutResponse.message;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "Transaction successful",
        message: message,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await makeCardPayment(amount, context);

  } else {
    String message  = checkoutResponse.message;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ));
  }
}



void payWithPayStack(String? amount,
    BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? email = preferences.getString("email");
  int randomInt = Random().nextInt(1000);
  PayWithPayStack payStack = PayWithPayStack();

  PayWithPayStack().now(
      context: context,
      secretKey: paystackSecretKey,
      customerEmail: email ?? "user${randomInt}@gmail.com",
      reference: DateTime.now().microsecondsSinceEpoch.toString(),
      currency: "NGN",
      amount: "${amount}00",
      transactionCompleted: () {
        print("testing");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Transaction Successful"),
          backgroundColor: Colors.redAccent,
        ));
        // await makeCardPayment(amount, context);
        changeScreen(context, WalletScreen());


        print("Transaction Successful");
      },
      transactionNotCompleted: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Transaction Failed"),
          backgroundColor: Colors.redAccent,
        ));
        print("Transaction Not Successful!");
        changeScreen(context, WalletScreen());
      });

}

void webPaystackView(String? amount, BuildContext context) async{

  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? email = preferences.getString("email");
  int randomInt = Random().nextInt(1000);

  final data = {
    "email": email?? "user$randomInt@gmail.com",
    "amount": "${amount}00"
  };
  var response = await CallPayStackApi().postData(data, "transaction/initialize");
  print(response);
  bool status = response['status'];
  final responseData = response['data'];

  if(status == true) {
    checkOutURL = responseData['authorization_url'];
    accessCode = responseData['access_code'];
    reference = responseData['reference'];
    print(reference);
    changeScreen(context, PayStackCheckOut(url: checkOutURL!, amount: amount!,));

  }
}

void verifyTransaction(String? amount, BuildContext context) async{
  final response = await CallPayStackApi().getData("transaction/verify/$reference");
  print(response);
  String status = response['data']['status'];
  if(status == "success") {

    deposit(amount!, context);
    String message =  response['data']['gateway_response'];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  removeScreenUntil(context, WalletScreen());
  }
  else {
    String message =  response['data']['gateway_response'];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    removeScreenUntil(context,WalletScreen());

  }
  
  reference = '';
  accessCode = '';
  checkOutURL = '';

}

