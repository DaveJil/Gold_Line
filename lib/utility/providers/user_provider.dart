import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/screens/authentication/user_navigation.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_profile/user_profile.dart';
import '../../screens/map/map_widget.dart';
import '../api.dart';
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
  UserProfile? _userModel;
  UserProfile? _userProfile;

  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

//  getter
  UserProfile get userModel => _userModel!;
  // Status get status => _status;
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

  Future signIn(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'login': email.text,
      'password': password.text,
    };

    try {
      var response = await CallApi().postData(request, 'login');
      print(response);
      String code = response['code'];

      if (code == 'success') {
        String token = response['token'];
        print(token);
        pref.setString('token', response['token']);
        pref.setBool(LOGGED_IN, true);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Welcome Back",
            message: "Login Successful",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        changeScreenReplacement(context, const MapWidget());
      } else {
        String message = response['message'];

        print(message);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: message,
            message: message,
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
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
      print(response);
      String code = response['code'];

      if (code == 'success') {
        String token = response['token'];
        print(token);
        pref.setString('token', response['token']);
        pref.setBool(LOGGED_IN, true);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Hey there",
            message: "Welcome to GoldLine. Account Created Successfully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        changeScreenReplacement(context, const MapWidget());
      } else {
        String message = response['message'];

        print(message);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: message,
            message: message,
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
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
      print(response);
      String code = response['code'];

      if (code == 'success') {
        String token = response['token'];
        print(token);
        pref.setString('token', response['token']);
        pref.setBool(LOGGED_IN, true);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Relax",
            message: "Check your email for the password rest link",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        changeScreenReplacement(context, const MapWidget());
      } else {
        String message = response['message'];

        print(message);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: message,
            message: message,
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return message;
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
    status = Status.Unauthenticated;
    await prefs.setString(ID, "");
    await prefs.setString(TOKEN, "");
    await prefs.setBool(LOGGED_IN, false);
    changeScreenReplacement(context, LoginChoice());

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  updateUserData(Map<String, dynamic> values) async {
    _userServices.updateUserData(values);
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

  // load userprofile
  Future<UserProfile> getProfile(BuildContext context) async {
    final profile = await _services.getUserProfile(context);
    _userProfile = profile;
    notifyListeners();
    return profile;
  }
}
