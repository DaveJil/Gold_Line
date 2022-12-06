import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: getHeight(50, context),
                        width: getWidth(250, context),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(20, context),
                      ),
                      Container(
                        height: getHeight(50, context),
                        width: getWidth(250, context),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(50, context),
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
      mainAxisAlignment: MainAxisAlignment.center,
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
          width: 15,
        ),
        const Text(
          "I agree with the terms and conditions that come with \n using this application.",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            // fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
