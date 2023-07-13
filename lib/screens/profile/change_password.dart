import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/proceed_login.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/routing.dart';
import '../../utility/providers/user_provider.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  ChangePassState createState() => ChangePassState();
}

class ChangePassState extends State<ChangePass> {
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
                  padding: EdgeInsets.only(top: getHeight(80, context)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: getWidth(20, context),
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
                        width: getWidth(20, context),
                      ),
                      AutoSizeText(
                        'Change your Account Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
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
                AutoSizeText(
                  'Please Fill Password Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Current Password',
                        hintText: 'Enter your Current Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Current Password';
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
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                        hintText: 'Enter your New Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter New Password';
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
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm New Password',
                        hintText: 'Confirm your New Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter New Password Confirmation';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: getHeight(80, context),
                ),
                TextButton(
                  onPressed: () async {
                    await userProvider.forgotPassword(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
                  },
                  child: const Text(
                    "Can't Change Password? Contact Support",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kPrimaryGoldColor,
                      fontSize: 18,
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
                    child: const AutoSizeText(
                      'Change Password',
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
