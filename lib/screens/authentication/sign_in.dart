import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/forgot_password.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/validators.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(150, context),
                ),
                child: const AutoSizeText(
                  "Welcome, Enter your Login Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                height: getHeight(20, context),
              ),
              SizedBox(
                  width: getWidth(400, context),
                  height: getWidth(400, context),
                  child: SvgPicture.asset("assets/login.svg")),
              SizedBox(
                height: getHeight(20, context),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(50, context)),
                child: TextFormField(
                  controller: userProvider.email,
                  validator: (String? val) {
                    if (!val!.isValidEmail) return 'Enter valid email';
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(40, context),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(50, context)),
                child: TextFormField(
                  controller: userProvider.password,
                  obscureText: true,
                  validator: (String? val) {
                    if (!val!.isValidPassword) return 'Enter valid password';
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                ),
              ),
              SizedBox(
                height: getHeight(50, context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                child: const AutoSizeText(
                  'New User? Create an account',
                  style: TextStyle(
                      color: kPrimaryGoldColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: getHeight(30, context),
              ),
              Container(
                height: getHeight(45, context),
                width: getWidth(200, context),
                decoration: BoxDecoration(
                    color: kPrimaryGoldColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    await userProvider.signIn(context);
                  },
                  child: const AutoSizeText(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(30, context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ForgotPass()));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: kPrimaryGoldColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
