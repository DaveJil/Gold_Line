import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/delivery_model/delivery.dart';
import '../../models/delivery_model/intercity_ride.dart';
import '../../models/notifications/notifications.dart';
import '../../models/transaction/transaction.dart';
import '../../screens/home/home_screen.dart';
import '../api.dart';
import '../helpers/custom_display_widget.dart';
import '../helpers/routing.dart';

class GetListProvider extends ChangeNotifier {
  TextEditingController cancelDescription = TextEditingController();
  String? rideCancelReason;

  List<DeliveryModel> _deliveryList = [];
  List<DeliveryModel> get deliveryList => _deliveryList;

  Future getDeliveryList() async {
    var response = await CallApi().getData('user/deliveries');
    print(response);
    final result = response["data"];
    final data = result.map((e) => DeliveryModel.fromJson(e)).toList();
    //////print("dat = $data");
    return data;
  }

  Future checkPendingDelivery() async {
    try {
      final response =
          await CallApi().getData('user/deliveries?status=pending');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkAcceptedDelivery() async {
    try {
      final response =
          await CallApi().getData('user/deliveries?status=accepted');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
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
          await CallApi().getData('user/deliveries?status=completed');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCancelledDelivery() async {
    try {
      final response =
          await CallApi().getData('user/deliveries?status=canceled');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkPendingInterStateDelivery() async {
    try {
      final response =
          await CallApi().getData('user/interstate/deliveries?status=pending');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkAcceptedInterStateDelivery() async {
    try {
      final response =
          await CallApi().getData('user/interstate/deliveries?status=accepted');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCompletedInterStateDelivery() async {
    try {
      final response = await CallApi()
          .getData('user/interstate/deliveries?status=completed');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCancelledInterStateDelivery() async {
    try {
      final response =
          await CallApi().getData('user/interstate/deliveries?status=canceled');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkPendingInternationalDelivery() async {
    try {
      final response = await CallApi()
          .getData('user/international/deliveries?status=pending');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkAcceptedInternationalDelivery() async {
    try {
      final response = await CallApi()
          .getData('user/international/deliveries?status=accepted');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCompletedInternationalDelivery() async {
    try {
      final response = await CallApi()
          .getData('user/international/deliveries?status=completed');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCancelledInternationalDelivery() async {
    try {
      final response = await CallApi()
          .getData('user/international/deliveries?status=canceled');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkPendingVansDelivery() async {
    try {
      final response =
          await CallApi().getData('user/cargo/deliveries?status=pending');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkAcceptedVansStateDelivery() async {
    try {
      final response =
          await CallApi().getData('user/cargo/deliveries?status=processing');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCompletedVansStateDelivery() async {
    try {
      final response =
          await CallApi().getData('user/cargo/deliveries?status=completed');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCancelledVansStateDelivery() async {
    try {
      final response =
          await CallApi().getData('user/cargo/deliveries?status=canceled');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkPendingInterCityRides() async {
    try {
      final response = await CallApi()
          .getData('user/interstate-transport/deliveries?status=pending');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => InterCityRideModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkAcceptedVInterCityRides() async {
    try {
      final response = await CallApi()
          .getData('user/interstate-transport/deliveries?status=accepted');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => InterCityRideModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCompletedInterCityRides() async {
    try {
      final response = await CallApi()
          .getData('user/interstate-transport/deliveries?status=completed');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => InterCityRideModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future checkCancelledIntercityRides() async {
    try {
      final response =
          await CallApi().getData('user/cargo/deliveries?status=canceled');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => InterCityRideModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future cancelDelivery(BuildContext context, String deliveryIde) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'delivery_id': deliveryIde,
      'reason_option': rideCancelReason ?? "other",
      'reason_description': rideCancelReason ?? cancelDescription.text
    };

    try {
      var response = await CallApi().postData(request, 'user/delivery/cancel');
      //print(response);
      String code = response['code'];
      String message = response['message'];
      CustomDisplayWidget.displayAwesomeSuccessSnackBar(context, code, message);

      if (code == "success") {
        changeScreenReplacement(context, HomeScreen());
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future confirmPickUp(BuildContext context, String? deliveryIde) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final response =
          await CallApi().postData("", 'user/delivery/start/$deliveryIde');
      String message = response["message"];
      //print(message);
      Navigator.pop(context);
      checkPendingDelivery();

      CustomDisplayWidget.displayAwesomeSuccessSnackBar(
          context, message, message);
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<List<Transactions>?> getTransactionList() async {
    try {
      final response = await CallApi().getData('user/transaction');
      print(response);
      final data = response['data'];
      print(data);
      final result = data.map((e) => Transactions.fromJson(e)).toList();
      print(result);
      return result;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
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
      //print(e);
    }
    notifyListeners();
  }
}
