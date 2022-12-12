import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/delivery_model/delivery.dart';
import '../../models/notifications/notifications.dart';
import '../../models/transaction/transaction.dart';
import '../api.dart';

class GetListProvider extends ChangeNotifier {
  List<DeliveryRequestModel> _deliveryList = [];
  List<DeliveryRequestModel> get deliveryList => _deliveryList;
  DeliveryRequestModel? deliveryModel;

  Future<List<DeliveryRequestModel>?> getdeliveryList() async {
    try {
      var response = await CallApi().getData('delivery');
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        res.forEach((delivery) {
          DeliveryRequestModel model = DeliveryRequestModel.fromJson(delivery);
          _deliveryList.add(model);
        });
        return _deliveryList;
      }
    } catch (e) {
      const SnackBar(content: AlertDialog());
      print(e);
    }
    notifyListeners();
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
