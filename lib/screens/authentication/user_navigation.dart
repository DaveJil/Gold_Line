import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({super.key});

  @override
  LoginChoiceState createState() => LoginChoiceState();
}

class LoginChoiceState extends State<LoginChoice> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.appWidth(context),
              vertical: 10.appHeight(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: getHeight(40, context),
                ),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: SvgPicture.asset("assets/started.svg")),
                SizedBox(
                  height: getHeight(20, context),
                ),
                const Text(
                  'Lets get you Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                Center(
                  child: const Text(
                    'Welcome, Please Choose your Login / SignUp Option',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kPrimaryGoldColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                const Text(
                  'Are you an Agent or a User?',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryGoldColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignUpScreen()));
                            },
                            child: const AutoSizeText(
                              'Sign Up as an Agent',
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.appWidth(context),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.appWidth(context)),
                          decoration: BoxDecoration(
                              color: kPrimaryGoldColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignUpScreen()));
                            },
                            child: AutoSizeText(
                              'Sign Up as a User',
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
                  },
                  child: Text(
                    'or Proceed to Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kPrimaryGoldColor,
                      fontWeight: FontWeight.w300,
                      fontSize: getHeight(22, context),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: getHeight(22, context),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                const BuildCheckBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Privacy Policy'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Expanded(
          child: AutoSizeText(
              "Goldline collects location data to enable ride-tracking feature, delivery tracking, & easy location setting even when the app is closed or not in use and it is also used to support advertising (even though we have no plans to advertise). Also, Location is used in price settings in giving favourable price to Users and Agents based on their location. When not in Use, Location is used to send Delivery Data to Riders and Rider Managers for Delivery Tracking. \n For more info, contact mail.goldline@gmail.com or call +2348138969994"),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

class BuildCheckBox extends StatefulWidget {
  const BuildCheckBox({Key? key}) : super(key: key);

  @override
  State<BuildCheckBox> createState() => _BuildCheckBoxState();
}

class _BuildCheckBoxState extends State<BuildCheckBox> {
  bool _isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
            value: _isAgree,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                _isAgree = !_isAgree;
              });
            }),
        SizedBox(
          width: 10.appWidth(context),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            },
            child: AutoSizeText(
              "I agree with the terms and conditions that come with using this application.",
              maxLines: 3,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                // fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
