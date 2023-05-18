import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';

import '../../../utility/helpers/dimensions.dart';


class WalletBalance extends StatelessWidget {
  const WalletBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryGoldColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: getHeight(20, context),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // title: const Text(
        //   'Wallet Balance',
        //   style: TextStyle(
        //       color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600),
        // ),
        //   actions: [
        //     const Icon(
        //       Icons.history,
        //       color: kPrimaryGoldColor,
        //     )
        //   ],
        //   backgroundColor: Colors.white,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              width: 500,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('assets/card.png')),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text('Today'),
                  const SizedBox(
                    height: 35,
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/wallet balance.svg"),
                    title: const Text("Wallet Balance"),
                    subtitle: const Text(
                        "Check all your Commissions from  your Referrals"),
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/refferals.svg"),
                    title: const Text("Referrals"),
                    subtitle: const Text("Refer Agents to MetroHub"),
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
