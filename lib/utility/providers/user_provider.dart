import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/screens/authentication/proceed_login.dart';
import 'package:gold_line/screens/authentication/user_navigation.dart';
import 'package:gold_line/utility/helpers/custom_display_widget.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_profile/user_profile.dart';
import '../../models/user_profile/get_data_model.dart';
import '../../screens/map/map_widget.dart';
import '../api.dart';
import '../helpers/upload_image.dart';
import '../services/user_services.dart';

enum Status { Uninitialized, Authenticated, Unauthenticated }

class UserProvider with ChangeNotifier {
  static const LOGGED_IN = "loggedIn";
  static const ID = "id";
  static const TOKEN = "token";
  static const FIRSTNAME = "first_name";

  final UserServices _services = UserServices();
  Status status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserProfile? userProfile;
  GetData? userData;
  String? deviceToken;
  String? referralId;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController otherName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userLGA = TextEditingController();
  TextEditingController userState = TextEditingController();

  String? firstNamePref;
  String? lastNamePref;
  String? emailPref;

  // public variables
  final formkey = GlobalKey<FormState>();

  UserProvider.initialize() {
    _initialize();
    saveDeviceToken();
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

  Future signIn(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> request = {
      'login': email.text,
      'password': password.text,
    };

    try {
      var response = await CallApi().postData(request, 'login');
      //print(response);
      String code = response['code'];
      if (code == 'success') {
        String token = response['token'];
        //print(token);
        firstNamePref = response['data']['profile']['first_name'];
        lastNamePref = response['data']['profile']['last_name'];
        emailPref = response['data']['email'];
        referralId = response['data']['uuid'];

        pref.setString('token', token);

        pref.setBool(LOGGED_IN, true);

        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Login Successful", "Welcome Back");
        await FirebaseMessaging.instance.requestPermission();
        String? deviceToken = await FirebaseMessaging.instance.getToken();
        //print(deviceToken);

        changeScreenReplacement(context, const MapWidget());
      } else {
        String message = response['message'];

        //print(message);
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, message);
        notifyListeners();
        return message;
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future signUp(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> request = {
      'first_name': firstName.text,
      'last_name': lastName.text,
      'email': email.text,
      'password': password.text,
    };

    try {
      final response = await CallApi().postData(request, 'signup');
      //print(response);
      String code = response['code'];
      if (code == 'success') {
        String token = response['token'];
        //print(token);
        pref.setString('token', response['token']);
        pref.setString('token', token);
        pref.setBool(LOGGED_IN, true);

        CustomDisplayWidget.displayAwesomeSuccessSnackBar(context, "Hey there!",
            "Welcome to GoldLine. Account Created Successfully");

        changeScreenReplacement(context, const MapWidget());
      } else {
        String message = response['message'];
        //print(message);
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, message);
        notifyListeners();

        return message;
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future forgotPassword(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'email': email.text,
    };

    try {
      final response = await CallApi().postData(request, 'forgot-password');
      //print(response);
      String code = response['code'];

      if (code == 'success') {
        changeScreen(context, ProceedLogin());
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Relax", "Check Email for password reset link");
      } else {
        String message = response['message'];

        //print(message);
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, message);
        return message;
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future updateProfile(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> request = {
      'login': email.text,
      'password': password.text,
    };

    try {
      var response = await CallApi().postData(request, 'profile');
      //print(response);
      String code = response['code'];
      if (code == 'success') {
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Congrats", "Profile updated successfully");
        await saveDeviceToken();
        changeScreenReplacement(context, const MapWidget());
      } else {
        String message = response['message'];

        //print(message);
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, message);
        return message;
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future updateProfilePic(BuildContext context) async {
    final file = await UploadFiles().getImage();
    // String profilePhoto = base64Encode(file.readAsBytesSync());
    //print(file);
    dynamic image = File(file).readAsBytesSync();
    // //print(profilePhoto);

    dynamic request = {};

    try {
      var response = await CallApi().addImage(request, 'profile', file, image);
      //print(response);
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<GetData?> getUserData(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      var response = await CallApi().getData('profile');
      //print(response);
      userData = GetData.fromJson(response['data']);
      //print(response['data']['email']);
      //print(userData);
      String code = response['code'];
      if (code == 'success') {
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Congrats", "Profile retrieved successfully");
        return userData;
      } else {
        String message = response['message'];

        //print(message);
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, message);
      }
      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await CallApi().getData('logout');
    status = Status.Unauthenticated;
    await prefs.setString(ID, "");
    await prefs.setString(TOKEN, "");
    await prefs.setBool(LOGGED_IN, false);
    changeScreenReplacement(context, LoginChoice());

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  saveDeviceToken() async {
    firebaseMessaging.requestPermission();
    deviceToken = await firebaseMessaging.getToken();
    var response =
        await CallApi().postData({"fcm_token": deviceToken}, "profile");
    notifyListeners();
    //print(response);
  }

  _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool(LOGGED_IN) ?? false;

    if (!loggedIn) {
      status = Status.Unauthenticated;
    } else {
      status = Status.Authenticated;
    }
    notifyListeners();
  }
}
