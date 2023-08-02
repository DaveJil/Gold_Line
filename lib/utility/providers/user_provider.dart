import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/screens/authentication/proceed_login.dart';
import 'package:gold_line/screens/authentication/user_navigation.dart';
import 'package:gold_line/screens/payment_screen/payment_details.dart';
import 'package:gold_line/screens/profile/profile.dart';
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
  UserProfile? userProfile;
  GetData? userData;
  String? deviceToken;
  String? referralId;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  TextEditingController otherName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userLGA = TextEditingController();
  TextEditingController userState = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();

  String? firstNamePref;
  String? lastNamePref;
  String? emailPref;
  String? phonePref;
  String userDropDownValue = 'User';

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
      print(response);
      String code = response['code'];
      if (code == 'success') {
        String token = response['token'];
        print(token);
        firstNamePref = response['data']['profile']['first_name'];
        lastNamePref = response['data']['profile']['last_name'];
        emailPref = response['data']['email'];
        phonePref = response['data']['phone'];

        referralId = response['data']['uuid'];
        int randomInt = Random().nextInt(100);

        pref.setString('token', token);
        pref.setString("email", emailPref ?? "user$randomInt@gmail.com");
        pref.setString(
            "phone", phonePref ?? "09$randomInt$randomInt$randomInt");

        pref.setBool(LOGGED_IN, true);

        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Login Successful", "Welcome Back");
        await FirebaseMessaging.instance.requestPermission();
        String? deviceToken = await FirebaseMessaging.instance.getToken();
        print(deviceToken);
        status = Status.Authenticated;

        removeScreenUntil(context, const MapWidget());
      } else {
        String message = response['message'].toString();

        print(message);
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
      'phone': phone.text,
      'password': password.text,
      'role': userDropDownValue.toLowerCase()
    };

    try {
      final response = await CallApi().postData(request, 'signup');
      print(response);
      String code = response['code'];
      if (code == 'success') {
        emailPref = response['data']['email'];
        phonePref = response['data']['phone'];
        int randomInt = Random().nextInt(100);

        String token = response['token'];
        print(token);
        pref.setString('token', response['token']);
        pref.setString('token', token);
        pref.setString("email", emailPref ?? "user@gmail.com");
        pref.setString(
            "phone", phonePref ?? "09$randomInt$randomInt$randomInt");

        pref.setBool(LOGGED_IN, true);
        status = Status.Authenticated;
        notifyListeners();

        CustomDisplayWidget.displayAwesomeSuccessSnackBar(context, "Hey there!",
            "Welcome to GoldLine. Account Created Successfully");

        changeScreen(context, const PaymentDetails());
      } else {
        String message = response['message'].toString();
        print(message);
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
      print(response);
      String code = response['code'];

      if (code == 'success') {
        changeScreen(context, ProceedLogin());
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(context, "Relax",
            "Please Check your Email for password reset link");
      } else {
        String message = response['message'].toString();

        print(message);
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

  Future changePassword(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> request = {
      'current_password': password.text,
      'new_password': newPassword.text,
      'password_confirmation': confirmNewPassword
    };

    try {
      final response = await CallApi().postData(request, 'forgot-password');
      print(response);
      String code = response['code'];

      if (code == 'success') {
        changeScreenReplacement(context, UserProfileScreen());
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "", "Password Reset Successfully");
      } else {
        String message = response['message'].toString();

        print(message);
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
      'email': email.text,
      'phone': phone.text,
      'address': userAddress.text
    };

    try {
      var response = await CallApi().postData(request, 'profile');
      print(response);
      String code = response['code'];
      if (code == 'success') {
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Congrats", "Profile updated successfully");
      } else {
        String message = response['message'].toString();

        print(message);
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
    print(file);
    dynamic image = File(file).readAsBytesSync();
    // print(profilePhoto);

    dynamic request = {};

    try {
      var response = await CallApi().addImage(request, 'profile', file, image);
      print(response);
      getUserData(context);
      changeScreenReplacement(context, UserProfileScreen());
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
      print(response);
      userData = GetData.fromJson(response['data']);
      String email = response['data']['email'];
      pref.setString('email', email);
      print(userData);
      String code = response['code'];
      if (code == 'success') {
        return userData;
      } else {
        String message = response['message'].toString();

        print(message);
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

  Future addBankDetails(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic formData = {
      'bank_name': bankNameController.text,
      'account_no': accountNumberController.text,
      'account_name': accountNameController.text,
    };

    try {
      final response = await CallApi().postData(formData, "bank/new");
      if (response['code'] == 'success') {
        removeScreenUntil(context, MapWidget());
      } else {
        String message = response['message'].toString();
        print(message);
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, message);
        return message;
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } on TimeoutException catch (_) {
      throw AppException(message: 'Service timeout, check internet connection');
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
    removeScreenUntil(context, LoginChoice());

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future deleteAccount(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await CallApi().postData(null, 'delete-account');
    print(response);
    CustomDisplayWidget.displaySnackBar(context, "Account Deleted Sucessfully");
    status = Status.Unauthenticated;
    await prefs.setString(ID, "");
    await prefs.setString(TOKEN, "");
    await prefs.setBool(LOGGED_IN, false);
    removeScreenUntil(context, LoginChoice());

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  saveDeviceToken() async {
    firebaseMessaging.requestPermission();
    deviceToken = await firebaseMessaging.getToken();
    var response =
        await CallApi().postData({"fcm_token": deviceToken}, "profile");
    notifyListeners();
    print(response);
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
