import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class UserServices {
  final CallApi _callApi = CallApi();

  void updateUserData(Map<String, dynamic> values) {
    CallApi().updateData(values, 'profile');
    // firebaseFirestore.collection(collection).doc(values['id']).update(values);
  }

  //
  // Future<UserProfile> getUserById() async {
  //   final response = await CallApi().getData('profile');
  //   return UserProfile.fromJson(response.body);
  // }

  void addDeviceToken({String? token, String? userId}) {
    Map<String, dynamic> request = {
      'token': token,
    };
    CallApi().patchData(request, 'user/register');
  }

  // create password
  Future signIn(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'email': email,
      'password': password,
    };

    try {
      final response = await _callApi.postData(request, 'login');

      if (response['success'] == "success") {
        final body = response;
        print('working');
        print(body);
        if ((body as Map<String, dynamic>).containsKey('token')) {
          pref.setString('token', body["token"]);
          print(body["token"]);
        } else {
          print('no token added');
        }
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future signUp(String name, String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      final response = await _callApi.postData(request, 'register');

      if (response['success'] == "success") {
        final body = response;
        print('working');
        print(body);
        if ((body as Map<String, dynamic>).containsKey('token')) {
          pref.setString('token', body["token"]);
          print(body["token"]);
        } else {
          print('no token added');
        }
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future requestDelivery(
    String senderName,
    String senderPhone,
    String receiverName,
    String receiverPhone,
    String description,
    double pickUpLatitude,
    String pickupAddress,
    String dropOffAddress,
    double dropOffLongitude,
    double dropOffLatitude,
    double pickUpLongitude,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'sender_name': senderName,
      'pickup_latitude': pickUpLatitude,
      'pickup_longitude': pickUpLongitude,
      'dropoff_longitude': dropOffLongitude,
      'dropoff_address': dropOffAddress,
      'pickup_address': pickupAddress,
      'dropoff_latitude': dropOffLatitude,
      'sender_phone': senderPhone
    };

    try {
      final response = await _callApi.postData(request, 'request_delivery');

      if (response['success'] == "success") {
        final body = response;
        print('working');
        print(body);
        if ((body as Map<String, dynamic>).containsKey('token')) {
          pref.setString('token', body["token"]);
          print(body["token"]);
        } else {
          print('no token added');
        }
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//
  // // load user profile
  // Future<UserProfile> getUserProfile(BuildContext context) async {
  //   UserProfile _userProfile = UserProfile();
  //   try {
  //     final response = await CallApi().getData('/profile');
  //     final data = response['data'];
  //     UserProfile profile = UserProfile.fromJson(data);
  //     _userProfile = profile;
  //   } catch (err) {
  //     CustomDisplayWidget.onErrorDialogBox(
  //         context, err.toString(), 'User not found');
  //   }
  //   return _userProfile;
  // }
}
