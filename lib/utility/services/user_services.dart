import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class UserServices {
  CallApi _callApi = CallApi();
  void createUser(
      {String? id,
      String? name,
      String? email,
      String? phone,
      String? dob,
      String? gender,
      String? photo,
      String? token,
      Map? position}) {
    Map<String, dynamic> request = {
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
      "position": position,
      'dob': dob,
      'gender': gender,
      'photo': photo,
      'token': token,
    };

    ///Update dataUrl
    CallApi().postData(request, 'register');
  }

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
  Future login(String email, String password) async {
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
    String receiverName,
    double pickUpLatitude,
    String pickupAddress,
    String dropoffAddress,
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
      'dropoff_address': dropoffAddress,
      'pickup_address': pickupAddress,
      'dropoff_latitude': dropOffLatitude,
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
