import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/profile/referral.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

import '../my_deliveries/my_deliveries.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Container(
              width: 500,
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
                  Text(
                    'Layade Joshua',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getHeight(16, context),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MyDeliveriesScreen()));
                    },
                  ),
                  SizedBox(
                    height: getHeight(35, context),
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/wallet balance.svg"),
                    title: const Text("Wallet Balance"),
                    subtitle: const Text(
                        "Check all your Commissions from  your Referrals"),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ReferralPage()));
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
                  ),
                  SizedBox(
                    height: getHeight(12, context),
                  ),
                  CustomButton(
                    onPressed: () {},
                    text: 'Log Out',
                    width: getWidth(161, context),
                    height: getHeight(38, context),
                  ),
                ],
              )),
        ));
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
