import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/delivery_model/delivery.dart';
import '../../models/notifications/notifications.dart';
import '../../models/transaction/transaction.dart';
import '../api.dart';

class GetListProvider extends ChangeNotifier {
  List<DeliveryModel> _deliveryList = [];
  List<DeliveryModel> get deliveryList => _deliveryList;

  Future getDeliveryList() async {
    var response = await CallApi().getData('user/deliveries');
    print(response);
    final result = response["data"];
    final data = result.map((e) => DeliveryModel.fromJson(e)).toList();
    print("dat = $data");
    return data;
  }

  Future checkPendingDelivery() async {
    try {
      final response =
          await CallApi().getData('user/deliveries?status=accepted');
      print(response);
      final data = response['data'];
      print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCompletedDelivery() async {
    try {
      final response =
          await CallApi().getData('users/deliveries?status=completed');
      print(response);
      final data = response['data'];
      print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  List<TransactionModel> _transactionList = [];
  List<TransactionModel> get transactionList => _transactionList;
  TransactionModel? transactionModel;

  Future<List<TransactionModel>?> getTransactionList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? id = preferences.getString('id');
      var response = await CallApi().getData('wallet/transaction/$id');
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        res.forEach((transaction) {
          TransactionModel model = TransactionModel.fromJson(transaction);
          _transactionList.add(model);
        });
        return _transactionList;
      }
    } catch (e) {
      const SnackBar(content: AlertDialog());
      print(e);
    }
    notifyListeners();
  }

  List<NotificationsModel> _notificationsList = [];
  List<NotificationsModel> get notificationsList => _notificationsList;
  NotificationsModel? notificationsModel;

  Future<List<NotificationsModel>?> getNotificationsList() async {
    try {
      var response = await CallApi().getData('notifications');
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        res.forEach((notification) {
          NotificationsModel model = NotificationsModel.fromJson(notification);
          _notificationsList.add(model);
        });
        return _notificationsList;
      }
    } catch (e) {
      const SnackBar(content: AlertDialog());
      print(e);
    }
    notifyListeners();
  }
}
