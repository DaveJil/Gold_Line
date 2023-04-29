import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_profile/user_profile.dart';
import '../api.dart';
import '../helpers/custom_display_widget.dart';

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
  Future<UserProfile> getUserById() async {
    final response = await CallApi().getData('profile');
    return UserProfile.fromJson(response.body);
  }

  void addDeviceToken({String? token, String? userId}) {
    Map<String, dynamic> request = {
      'token': token,
    };
    CallApi().patchData(request, 'user/register');
  }

  // create password
  Future signUps(String phone, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'phone': phone,
      'password': password,
    };

    try {
      final response = await _callApi.postData(request, 'signup/');

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

  // load user profile
  Future<UserProfile> getUserProfile(BuildContext context) async {
    UserProfile _userProfile = UserProfile();
    try {
      final response = await CallApi().getData('profile');
      final data = response['data'];
      UserProfile profile = UserProfile.fromJson(data);
      _userProfile = profile;
    } catch (err) {
      CustomDisplayWidget.onErrorDialogBox(
          context, err.toString(), 'User not found');
    }
    return _userProfile;
  }
}
