import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ReferralPage extends StatelessWidget {
  final String uuid;
  const ReferralPage({Key? key, required this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: getHeight(20, context),
            color: kPrimaryGoldColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Referral',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 50.appWidth(context),
                vertical: 30.appHeight(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset('assets/friends.svg'),
                ),
                SizedBox(
                  height: 10.appHeight(context),
                ),
                const Center(
                  child: Text(
                    "Refer And Earn",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.brown, shape: BoxShape.circle),
                      child: const Text(
                        "1",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 50.appWidth(context),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Invite Your Friends",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5.appHeight(context)),
                        const Text(
                          "Ask them to Input your referral code on Sign Up",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.appHeight(context)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.brown, shape: BoxShape.circle),
                      child: const Text(
                        "2",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 50.appWidth(context),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "They hit the road",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5.appHeight(context)),
                        const Text(
                          "Your friend makes his first delivery",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.appHeight(context)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.brown, shape: BoxShape.circle),
                      child: const Text(
                        "3",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 50.appWidth(context),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "You receive your bonus",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5.appHeight(context)),
                          const Text(
                            "Your wallet balance is credited with NGN 499 on their first sucessful delivery",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.appHeight(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Referrals",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 5.appHeight(context),
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                              color: kPrimaryGoldColor, shape: BoxShape.circle),
                          child: const Text(
                            "0",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Amount Earned",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10.appHeight(context),
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: kPrimaryGoldColor,
                              borderRadius: BorderRadius.circular(40)),
                          child: const AutoSizeText(
                            "₦ 0.00",
                            maxLines: 1,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 25.appHeight(context),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Referral Code:   $uuid",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(
                        width: 20.appWidth(context),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: "${userProvider.referralId}"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Referral Code Copied to Clipboard"),
                          ));
                        },
                        child: const Icon(
                          FontAwesomeIcons.solidCopy,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
