import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Main Menu',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              width: 500,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/my history.svg"),
                    title: const Text("My History"),
                    subtitle: const Text("View all your previous transactions"),
                    trailing: const Icon(
                      Icons.arrow_circle_right_sharp,
                      color: kPrimaryGoldColor,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
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
                  const SizedBox(
                    height: 35,
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/refferals.svg"),
                    title: const Text("Referrals"),
                    subtitle: const Text("Refer Agents to MetroHub"),
                    trailing: const Icon(
                      Icons.arrow_circle_right_sharp,
                      color: kPrimaryGoldColor,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
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
                  const SizedBox(
                    height: 35,
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
                  const SizedBox(height: 35),
                  CustomButton(
                    onPressed: () {},
                    text: 'Log Out',
                    width: 161,
                    height: 38,
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
