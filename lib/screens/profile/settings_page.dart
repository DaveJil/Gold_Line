import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/authentication/kyc_info.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/user_provider.dart';
import 'change_password.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: getHeight(20, context),
          color: kPrimaryGoldColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Settings',
          style: TextStyle(
              color: Colors.black,
              fontSize: getHeight(28, context),
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: getHeight(50, context),
            ),
            SizedBox(
              height: getHeight(15, context),
            ),
            SizedBox(
              height: getHeight(45, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/my history.svg"),
              title: const Text("Edit your Profile"),
              subtitle: const Text("Upload your KYC Details"),
              trailing: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryGoldColor,
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => KycInfo()));
              },
            ),
            SizedBox(
              height: getHeight(35, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/wallet balance.svg"),
              title: const Text("Change Password"),
              subtitle:
                  const Text("Protect your Account by Changing your Password"),
              trailing: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryGoldColor,
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ChangePass()));
              },
            ),
            SizedBox(
              height: getHeight(35, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/refferals.svg"),
              title: const Text("Contact Support"),
              subtitle: const Text("Have an issues, contact support"),
              trailing: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryGoldColor,
              ),
              onTap: () {
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: "Coming soon",
                    message: "You will soon be able to contact support",
                    contentType: ContentType.help,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
            ),
            SizedBox(
              height: getHeight(35, context),
            ),
          ],
        )),
      ),
    );
  }
}
