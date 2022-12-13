import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/authentication/user_navigation.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_profile/user_profile.dart';
import '../api.dart';
import '../services/user_services.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  static const LOGGED_IN = "loggedIn";
  static const ID = "id";
  static const TOKEN = "token";
  static const FIRSTNAME = "first_name";

  final UserServices _services = UserServices();
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserProfile? _userModel;
  UserProfile? _userProfile;

  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

//  getter
  UserProfile get userModel => _userModel!;
  Status get status => _status;
  UserProfile get userProfile => _userProfile!;

  // public variables
  final formkey = GlobalKey<FormState>();

  UserProvider.initialize() {
    _initialize();
  }

  _showMsg(msg, BuildContext context) {
    //
    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future signIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'email': email.text,
      'password': password.text,
    };

    try {
      final response = await CallApi().postData(request, 'login');
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

  Future signUp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'first_name': firstName.text,
      'last_name': lastName.text,
      'email': email.text,
      'password': password.text,
    };

    try {
      final response = await CallApi().postData(request, 'signup');
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

  Future signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await CallApi().getData('logout');
    _status = Status.Unauthenticated;
    await prefs.setString(ID, "");
    await prefs.setString(TOKEN, "");
    await prefs.setBool(LOGGED_IN, false);
    changeScreenReplacement(context, LoginChoice());

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // void clearController() {
  //   password.text = "";
  //   email.text = "";
  //   fullName.text = "";
  // }

  Future<void> reloadUserModel() async {
    ///TODO FIX THIS
    _userModel = await _userServices.getUserById();
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> values) async {
    _userServices.updateUserData(values);
  }
  //
  // saveDeviceToken() async {
  //   String? deviceToken = await firebaseMessaging.getToken();
  //   if (deviceToken != null) {
  //     _userServices.addDeviceToken(userId: user.uid, token: deviceToken);
  //   }
  // }

  _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool(LOGGED_IN) ?? false;
    if (!loggedIn) {
      _status = Status.Unauthenticated;
    } else {
      ///TODO FIX ERROR
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById();
    }
    notifyListeners();
  }

  // load userprofile
  Future<UserProfile> getProfile(BuildContext context) async {
    final profile = await _services.getUserProfile(context);
    _userProfile = profile;
    notifyListeners();
    return profile;
  }
}
