// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutterwave/flutterwave.dart';
// import 'package:flutterwave/models/responses/charge_response.dart';
// import 'package:safedrop_user/models/ride_request/ride_request.dart';
// import 'package:safedrop_user/models/transaction/transaction.dart';
// import 'package:safedrop_user/models/user_profile/user_profile.dart';
// import 'package:safedrop_user/routes/routes.dart';
// import 'package:safedrop_user/screens/map_screen/map_view.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../utility/api/api.dart';
//
// var txRef = Uuid().v1();
//
// UserProfile userModel = UserProfile();
// TransactionModel transactionModel = TransactionModel();
// RideRequestModel? rideRequestModel = RideRequestModel();
//
// Future<void> makeCardPayment(
//   BuildContext context,
//   String name,
//   String email,
//   String amount,
//   String phoneNumber,
// ) async {
//   Flutterwave flutterWave = Flutterwave.forUIPayment(
//       context: context,
//       acceptCardPayment: true,
//       acceptAccountPayment: false,
//       acceptBankTransfer: false,
//       publicKey: "",
//       encryptionKey: "",
//       currency: FlutterwaveCurrency.NGN,
//       amount: amount,
//       email: email,
//       fullName: name,
//       txRef: "SafeTRX" + txRef,
//       isDebugMode: true,
//       phoneNumber: phoneNumber);
//
//   final ChargeResponse response = await flutterWave.initializeForUiPayments();
//
//   if (response.status == "success") {
//     Map<String, dynamic> request = {
//       'amount': amount,
//       'trxId': txRef,
//       'userId': transactionModel.user_id,
//       'driverId': transactionModel.driver_id,
//       'status': transactionModel.status,
//       'rider_manager_id': transactionModel.rider_manager_id,
//       'purpose': transactionModel.purpose
//     };
//     Map<String, dynamic> result = {
//       "success": false,
//       "message": 'Unknown error.'
//     };
//
//     var response = await CallApi().postData(request, 'register');
//     var body = json.decode(response.body);
//     print(body);
//     if (response.statusCode == 200) {
//       result['success'] = true;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Payment Successful")));
//       changeScreenReplacement(context, const MapHomePage());
//     }
//   } else {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("Payment Unsuccessful")));
//   }
// }
