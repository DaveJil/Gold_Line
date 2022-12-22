import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/authentication/kyc_info.dart';
import 'package:gold_line/screens/profile/profile.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/user_provider.dart';
import '../my_deliveries/my_deliveries.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: getHeight(20, context),
          color: kPrimaryGoldColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Account',
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
            Stack(children: [
              Container(
                height: getHeight(150, context),
                width: getHeight(136, context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  border: Border.all(
                    width: 1.appWidth(context),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              const Positioned(
                right: 7.23,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.camera_enhance_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: getHeight(15, context),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UserProfileScreen()));
              },
              child: Text(
                'Click to View Profile',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.grey,
                  fontSize: getHeight(16, context),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(45, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/my history.svg"),
              title: const Text("My History"),
              subtitle: const Text("View all your previous transactions"),
              trailing: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryGoldColor,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MyDeliveriesScreen()));
              },
            ),
            SizedBox(
              height: getHeight(35, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/wallet balance.svg"),
              title: const Text("Wallet Balance"),
              subtitle:
                  const Text("Check all your Commissions from  your Referrals"),
              trailing: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryGoldColor,
              ),
            ),
            SizedBox(
              height: getHeight(35, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/refferals.svg"),
              title: const Text("Referrals"),
              subtitle: const Text("Refer Agents to MetroHub"),
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
                    title: "Coming Soon",
                    message:
                        "You would soon be able to refer your friends and earn money",
                    contentType: ContentType.help,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);

                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => ReferralPage()));
              },
            ),
            SizedBox(
              height: getHeight(35, context),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/my coupons.svg"),
              title: const Text("My Coupons"),
              subtitle: const Text("View all your discounted offers"),
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
                    message:
                        "Coupons for discounts and promos would be available on the next update",
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
            ListTile(
              leading: SvgPicture.asset("assets/settings.svg"),
              title: const Text("Settings"),
              subtitle: const Text("Edit your preferences"),
              trailing: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryGoldColor,
              ),
              onTap: () {
                changeScreen(context, KycInfo());
              },
            ),
            SizedBox(
              height: getHeight(12, context),
            ),
            CustomButton(
              width: getWidth(170, context),
              onPressed: () {
                userProvider.signOut(context);
              },
              text: 'Log Out',
            ),
          ],
        )),
      ),
    );
  }
}

//class _MainMenuState extends State<MainMenu> {
//Timer? _timer;

// @override
// void initState() {
// super.initState();
//  loadScreen();
// }

//void loadScreen() {
//   _timer = Timer(const Duration(seconds: 3), goNext);
// }

// goNext() {
//   Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) => const LoginChoice()));
//  var width = MediaQuery.of(context).size.width;
//   print(width);
//   var height = MediaQuery.of(context).size.height;
//  print(height);
// }
