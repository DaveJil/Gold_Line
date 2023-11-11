import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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

  Future getDeliveryList(BuildContext context) async {
    var response = await CallApi().getData('user/deliveries');
    print(response);
    final result = response["data"];

    final data = result.map((e) => DeliveryModel.fromJson(e)).toList();
    //////print("dat = $data");
    return data;
  }

  Future checkPendingDelivery(BuildContext context) async {
    try {
      final response =
          await CallApi().getData('user/deliveries?status=processing');
      print(response);
      final data = response['data'];
      print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      print(result);
      return result;
    } on SocketException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkAcceptedDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCompletedDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCancelledDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkPendingInterStateDelivery(BuildContext context) async {
    try {
      final response = await CallApi()
          .getData('user/interstate/deliveries?status=processing');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkAcceptedInterStateDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCompletedInterStateDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCancelledInterStateDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkPendingInternationalDelivery(BuildContext context) async {
    try {
      final response = await CallApi()
          .getData('user/international/deliveries?status=processing');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => DeliveryModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkAcceptedInternationalDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCompletedInternationalDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCancelledInternationalDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkPendingVansDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkAcceptedVansStateDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCompletedVansStateDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCancelledVansStateDelivery(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkPendingInterCityRides(BuildContext context) async {
    try {
      final response = await CallApi()
          .getData('user/interstate-transport/deliveries?status=processing');
      print(response);
      final data = response['data'];
      //print(data);
      final result = data.map((e) => InterCityRideModel.fromJson(e)).toList();
      //print(result);
      return result;
    } on SocketException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkAcceptedVInterCityRides(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCompletedInterCityRides(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future checkCancelledIntercityRides(BuildContext context) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreen(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future cancelDelivery(BuildContext context, String deliveryIde) async {
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
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future confirmPickUp(BuildContext context, String? deliveryIde) async {
    try {
      final response =
          await CallApi().postData("", 'user/delivery/start/$deliveryIde');
      String message = response["message"];
      //print(message);
      Navigator.pop(context);
      checkPendingDelivery(context);

      CustomDisplayWidget.displayAwesomeSuccessSnackBar(
          context, message, message);
    } on SocketException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  Future<List<Transactions>?> getTransactionList(BuildContext context) async {
    try {
      final response = await CallApi().getData('user/transaction');
      print(response);
      final data = response['data'];
      print(data);
      final result = data.map((e) => Transactions.fromJson(e)).toList();
      print(result);
      return result;
    } on SocketException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on TimeoutException {
      changeScreenReplacement(
          context,
          AppException(
              message: "No/Poor internet Connection. Try again later"));
    } on Exception {
      changeScreenReplacement(context,
          AppException(message: "Something Went Wrong Try again Later"));
    } catch (err) {
      changeScreenReplacement(context,
          AppException(message: "Something went wrong. Try again later"));
      print(err.toString());
    }
  }

  List<NotificationsModel> _notificationsList = [];
  List<NotificationsModel> get notificationsList => _notificationsList;
  NotificationsModel? notificationsModel;

  Future<List<NotificationsModel>?> getNotificationsList(
      BuildContext context) async {
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
