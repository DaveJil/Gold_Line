import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/map_widget.dart';
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

//  getter
  UserProfile get userModel => _userModel!;
  Status get status => _status;
  UserProfile get userProfile => _userProfile!;

  // public variables
  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController fullName = TextEditingController();

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

  Future<bool> signIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.Authenticating;

      Map<String, dynamic> request = {
        'login': email.text.trim(),
        'password': password.text.trim(),
      };

      var response = await CallApi().postData(request, 'login');
      var body = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        prefs.setString(TOKEN, body['token']);
        prefs.setString(ID, json.encode(body['id']));
        await prefs.setBool(LOGGED_IN, true);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MapWidget()));
      } else {
        _showMsg(body['message'], context);
      }
      notifyListeners();

      // _userModel = await _userServices.getUserById(value.user!.uid);

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.Authenticating;

      Map<String, dynamic> request = {
        'email': email.text.trim(),
        'password': password.text.trim(),
      };

      var response = await CallApi().postData(request, 'login');
      var body = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        prefs.setString(TOKEN, body['token']);
        prefs.setString(ID, json.encode(body['id']));
        await prefs.setBool(LOGGED_IN, true);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MapWidget()));
      } else {
        _showMsg(body['message'], context);
      }
      notifyListeners();

      // _userModel = await _userServices.getUserById(value.user!.uid);

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await CallApi().getData('logout');
    _status = Status.Unauthenticated;
    await prefs.setString(ID, "");
    await prefs.setString(TOKEN, "");
    await prefs.setBool(LOGGED_IN, false);
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    password.text = "";
    email.text = "";
    fullName.text = "";
  }

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
