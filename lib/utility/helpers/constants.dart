import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// all app constants goes here

//APP CONSTANTS
const String appName = "SAFEDROP";
const String currentVersion = "1.0";
const String logoLocation = "assets/logo/logo.png";
const double kDefaultPadding = 20.0;
const double kDefaultMargin = 20.0;
const double kDefaultHeight = 20.0;
const String appFont = "Poppins";

const HAS_PERMISSION = "has_permission";
const LOCATION_ENABLED = "location_enabled";
const GOOGLE_MAPS_API_KEY = "AIzaSyAbncVH9Pjn3jurZ2N12nnit6js3XPAqtc";

const COUNTRY = "country";
const BASEURL = 'http://thesafedrop.herokuapp.com';

//COLORS
const Color kVistaWhite = Color.fromRGBO(253, 252, 250, 1);
const Color kPrimaryGoldColor = Color.fromRGBO(228, 169, 13, 1);
const Color kSecondBlueColor = Color.fromRGBO(0, 162, 237, 1);
const Color kTextGrey = Color.fromRGBO(243, 243, 243, 1);
const Color kSecondaryColor = Color.fromRGBO(10, 36, 66, 1);
const Color kSecondaryColorLight = Color.fromRGBO(71, 90, 112, 1);
const Color kLightSecondaryColor = Color.fromRGBO(59, 80, 104, 1);

// DEFAULT BACKGROUND IMAGE LOCATION ....
const String defaultLightBackgroundLocation =
    "assets/theme/default_background_light.png";
const String defaultDarkBackgroundLocation =
    "assets/theme/default_background_dark.png";

/// NO INTERNET JSONS
const String noInternetJsonLight = "assets/lottie/no_internet.json";
const String noInternetJsonDark = "assets/lottie/no_internet_night.json";
const String connectToInternet =
    "Kindly connect to an network to load recent data";

TextStyle labelTextStyles = const TextStyle(
  fontSize: 14,
  color: Color.fromRGBO(153, 153, 153, 1),
);

TextStyle hintTextStyles = const TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(153, 153, 153, 1),
);

InputDecorationTheme textFeildInputDecoration = InputDecorationTheme(
  fillColor: const Color.fromRGBO(153, 153, 153, 1),
  filled: true,
  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(16.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryGoldColor, width: 1.0),
  ),
  labelStyle: labelTextStyles,
  hintStyle: hintTextStyles,
);

String getFormattedDate(String timestamp) {
  try {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return DateFormat('MMM dd, yyyy').format(dateTime);
  } catch (exception) {
    return "";
  }
}
