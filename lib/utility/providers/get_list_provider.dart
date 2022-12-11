import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/delivery_model/delivery.dart';
import '../../models/transaction/transaction.dart';
import '../api.dart';
i
class GetListProvider extends ChangeNotifier {


  List<RideRequestModel> _tripList = [];
  List<RideRequestModel> get tripList => _tripList;
  RideRequestModel? tripModel;

  Future<List<RideRequestModel>?> getTripList() async {
    try {
      var response = await CallApi().getData('delivery');
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        res.forEach((trip) {
          RideRequestModel model = RideRequestModel.fromJson(trip);
          _tripList.add(model);
        });
        return _tripList;
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
}
