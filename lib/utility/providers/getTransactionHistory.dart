import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/bottom_sheets/searching%20for%20driver.dart';
import 'package:gold_line/screens/payment_screen/payment_details.dart';
import 'package:gold_line/screens/profile/wallet/paystack_checkout.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/helpers/custom_display_widget.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/services/paystack_api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/transaction/transactions.dart';
import '../api.dart';
import 'map_provider.dart';

enum OrderPaymentMethod { cash, card, wallet }

class OrderPaymentProvider with ChangeNotifier {
  OrderPaymentMethod _orderPaymentMethod = OrderPaymentMethod.card;

  OrderPaymentMethod get orderPaymentMethod => _orderPaymentMethod;

  set setTransactionsTypeEnum(OrderPaymentMethod paymentMethod) {
    _orderPaymentMethod = paymentMethod;
    notifyListeners();
  }
}

Transactions? transactions = Transactions();
String? checkOutURL;
String? accessCode;
String? reference;

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
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet COnnection. Try again later"));
  } on TimeoutException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet Connection. Try again later"));
  } on Exception {
    changeScreenReplacement(
        context, AppException(message: "Something Went Wrong Try again Later"));
  } catch (err) {
    changeScreenReplacement(context,
        AppException(message: "Something went wrong. Try again later"));
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
      changeScreenReplacement(context, const WalletScreen());
    } else {
      String message = response['message'];
      {
        CustomDisplayWidget.displaySnackBar(context, message);
        changeScreenReplacement(context, const WalletScreen());
      }
    }
  } on SocketException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet COnnection. Try again later"));
  } on TimeoutException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet Connection. Try again later"));
  } on Exception {
    changeScreenReplacement(
        context, AppException(message: "Something Went Wrong Try again Later"));
  } catch (err) {
    changeScreenReplacement(context,
        AppException(message: "Something went wrong. Try again later"));
  }
}

Future interWalletTransfer(
    String amount, String email, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  Map<String, dynamic> request = {'amount': amount, 'email': email};

  try {
    var response = await CallApi().postData(request, 'wallet/transfer');
    print(response);
    String code = response['code'];
    if (code == "success") {
      changeScreenReplacement(context, const WalletScreen());
      CustomDisplayWidget.displaySnackBar(context, "Transfer sucessful");
      changeScreenReplacement(context, const WalletScreen());
    } else {
      String message = response['message'];
      {
        CustomDisplayWidget.displaySnackBar(context, message);
        changeScreenReplacement(context, const WalletScreen());
      }
    }
  } on SocketException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet COnnection. Try again later"));
  } on TimeoutException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet Connection. Try again later"));
  } on Exception {
    changeScreenReplacement(
        context, AppException(message: "Something Went Wrong Try again Later"));
  } catch (err) {
    changeScreenReplacement(context,
        AppException(message: "Something went wrong. Try again later"));
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

      changeScreenReplacement(context, const WalletScreen());
    } else {
      String message = response['message'];
      String code = response['code'];

      CustomDisplayWidget.displaySnackBar(context, message);

      if (code == "bank-not-found") {
        await CustomDisplayWidget.displaySnackBar(context, message);

        changeScreenReplacement(context, const PaymentDetails());
      }
    }
  } on SocketException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet COnnection. Try again later"));
  } on TimeoutException {
    changeScreenReplacement(context,
        AppException(message: "No/Poor internet Connection. Try again later"));
  } on Exception {
    changeScreenReplacement(
        context, AppException(message: "Something Went Wrong Try again Later"));
  } catch (err) {
    changeScreenReplacement(context,
        AppException(message: "Something went wrong. Try again later"));
  }
}

void payStackDeposit(String? amount, BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? email = preferences.getString("email");
  int randomInt = Random().nextInt(1000);

  final data = {
    "email": email ?? "user$randomInt@gmail.com",
    "amount": "${amount}00"
  };
  var response =
      await CallPayStackApi().postData(data, "transaction/initialize");
  print(response);
  bool status = response['status'];
  final responseData = response['data'];

  if (status == true) {
    checkOutURL = responseData['authorization_url'];
    accessCode = responseData['access_code'];
    reference = responseData['reference'];
    print(reference);
    changeScreen(
        context,
        PayStackCheckOut(
          url: checkOutURL!,
          amount: amount!,
        ));
  }
}

void payStackDelivery(String? amount, BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? email = preferences.getString("email");
  int randomInt = Random().nextInt(1000);

  final data = {
    "email": email ?? "user$randomInt@gmail.com",
    "amount": "${amount}00"
  };
  var response =
      await CallPayStackApi().postData(data, "transaction/initialize");
  print(response);
  bool status = response['status'];
  final responseData = response['data'];

  if (status == true) {
    checkOutURL = responseData['authorization_url'];
    accessCode = responseData['access_code'];
    reference = responseData['reference'];
    print(reference);
    changeScreen(
        context,
        PayStackCheckOut(
          url: checkOutURL!,
          amount: amount!,
        ));
  }
}

void verifyTransaction(String? amount, BuildContext context) async {
  final response =
      await CallPayStackApi().getData("transaction/verify/$reference");
  print(response);
  String status = response['data']['status'];
  if (status == "success") {
    deposit(amount!, context);
    String message = response['data']['gateway_response'];
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    await getWalletBalance(context);

    removeScreenUntil(context, const WalletScreen());
  } else {
    String message = response['data']['gateway_response'];
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    await getWalletBalance(context);

    removeScreenUntil(context, const WalletScreen());
  }

  reference = '';
  accessCode = '';
  checkOutURL = '';
}

void verifyDeliveryPayment(String? amount, BuildContext context) async {
  final response =
      await CallPayStackApi().getData("transaction/verify/$reference");
  print(response);
  String status = response['data']['status'];
  if (status == "success") {
    deposit(amount!, context);
    String message = response['data']['gateway_response'];
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    final provider = Provider.of<MapProvider>(context);
    await provider.submitCardDelivery(context);
    removeScreenUntil(context, const SearchingForDriver());
  } else {
    String message = response['data']['gateway_response'];
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    removeScreenUntil(context, const WalletScreen());
  }

  reference = '';
  accessCode = '';
  checkOutURL = '';
}
