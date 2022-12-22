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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
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
                const Text(
                  'Welcome, Please Choose your Login / SignUp Option',
                  style: TextStyle(
                      color: kPrimaryGoldColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
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
                            child: const Text(
                              'Sign Up as an Agent',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.appWidth(context)),
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
                            child: const Text(
                              'Sign Up as a User',
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
          child: const AutoSizeText(
            "I agree with the terms and conditions that come with using this application.",
            maxLines: 3,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              // fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
