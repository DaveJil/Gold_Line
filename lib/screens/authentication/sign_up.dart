import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/custom_button.dart';
import '../../utility/providers/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final formGlobalKey = GlobalKey<FormState>();

    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: getHeight(50, context)),
                    child: Text(
                      "Let's get you Started",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: getHeight(26, context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(40, context),
                  ),
                  SizedBox(
                      width: getHeight(250, context),
                      height: getHeight(250, context),
                      child: SvgPicture.asset("assets/signup.svg")),
                  SizedBox(
                    height: getHeight(60, context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(30, context),
                    ),
                    child: TextFormField(
                      controller: userProvider.firstName,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryGoldColor,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          hintText: 'Enter your First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(20, context)),
                    child: TextFormField(
                      controller: userProvider.lastName,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryGoldColor,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: ' Last Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          hintText: 'Enter your Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(20, context)),
                    child: TextFormField(
                      controller: userProvider.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryGoldColor,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: ' Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: 'Enter valid email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(20, context)),
                    child: TextFormField(
                      controller: userProvider.password,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 6) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryGoldColor,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: ' Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          hintText: 'Enter secure password'),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(20, context)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryGoldColor,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: ' Confirm Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          hintText: 'Enter password again'),
                      validator: (value) {
                        if (value != userProvider.password.text ||
                            value!.length <= 6) {
                          return 'Confirm password must match password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(20, context)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryGoldColor,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: ' Referral Code(Optional)',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          hintText: 'Enter referral Code'),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignInScreen()));
                    },
                    child: AutoSizeText(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: kPrimaryGoldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(30, context),
                  ),
                  CustomButton(
                    width: width / 3,
                    onPressed: () async {
                      if (formGlobalKey.currentState!.validate()) {
                        await userProvider.signUp(context);
                      }
                    },
                    text: 'Sign Up',
                  ),
                  SizedBox(
                    height: getHeight(130, context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
