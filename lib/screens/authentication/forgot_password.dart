import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/proceed_login.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/routing.dart';
import '../../utility/providers/user_provider.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  ForgotPassState createState() => ForgotPassState();
}

class ForgotPassState extends State<ForgotPass> {
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
                  child: Row(
                    children: [
                      SizedBox(
                        width: getWidth(40, context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: getHeight(20, context),
                        color: kPrimaryGoldColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: getWidth(40, context),
                      ),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                SizedBox(
                    width: getHeight(300, context),
                    height: getHeight(300, context),
                    child: SvgPicture.asset("assets/forgotpass.svg")),
                SizedBox(
                  height: getHeight(40, context),
                ),
                const Text(
                  'Enter your Registered Email Address',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    controller: userProvider.email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                        hintText: 'Enter your Email Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                SizedBox(
                  height: getHeight(100, context),
                ),
                TextButton(
                  onPressed: () async {
                    await userProvider.forgotPassword(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kPrimaryGoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
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
                      await userProvider.forgotPassword(context);
                      changeScreenReplacement(context, ProceedLogin());
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.white, fontSize: 22),
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
