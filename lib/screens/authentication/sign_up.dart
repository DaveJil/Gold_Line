import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: getHeight(100, context)),
                  child: const Text(
                    'Lets get you Started',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                SizedBox(
                    width: getHeight(300, context),
                    height: getHeight(300, context),
                    child: SvgPicture.asset("assets/signup.svg")),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    controller: userProvider.firstName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
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
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    controller: userProvider.lastName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
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
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email',
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    controller: userProvider.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter password again'),
                    validator: (value) {
                      if (value != userProvider.password.text) {
                        return 'Confirm password must match password';
                      }
                      return null;
                    },
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
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: getHeight(30, context),
                ),
                Container(
                  height: getHeight(50, context),
                  width: getWidth(250, context),
                  decoration: BoxDecoration(
                      color: kPrimaryGoldColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async {
                      await userProvider.signUp(context);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(130, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
