import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
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
                padding: EdgeInsets.only(top: getHeight(150, context)),
                child: const Text(
                  "Welcome, Enter your Login Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
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
                child: const TextField(
                  decoration: InputDecoration(
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
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
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
                child: const Text(
                  'New User? Create an account',
                  style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                ),
              ),
              SizedBox(
                height: getHeight(30, context),
              ),
              Container(
                height: getHeight(90, context),
                width: getWidth(400, context),
                decoration: BoxDecoration(
                    color: kPrimaryGoldColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    await userProvider.signIn(context);
                  },
                  child: const Text(
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
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
