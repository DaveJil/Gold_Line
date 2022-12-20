import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: getHeight(20, context),
            color: kPrimaryGoldColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Referral',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getHeight(40, context),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(
                              'Get up to NGN 1000 on their first order',
                              style: TextStyle(
                                fontSize: getHeight(25, context),
                                fontWeight: FontWeight.w700,
                                color: kPrimaryGoldColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(40, context),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(70, 0, 0, 70),
                            width: 234,
                            height: 187.1,
                            child: SvgPicture.asset('assets/friends.svg'),
                          ),
                          SizedBox(
                            height: getHeight(30, context),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 17, 0),
                            width: getWidth(298, context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 14),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 11, 14),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 20, 0),
                                                width: getWidth(38, context),
                                                height: getHeight(38, context),
                                                child: SvgPicture.asset(
                                                  'assets/arrow.svg',
                                                  width: getWidth(38, context),
                                                  height:
                                                      getHeight(38, context),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              " Invite your friends to Goldline",
                                              style: TextStyle(
                                                fontSize:
                                                    getHeight(16, context),
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryGoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(16, context),
                                      ),
                                      SizedBox(
                                        // margin: const EdgeInsets.fromLTRB(0, 0, 11, 14),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 20, 0),
                                                width: getWidth(38, context),
                                                height: getHeight(38, context),
                                                child: SvgPicture.asset(
                                                  'assets/shopping.svg',
                                                  width: getWidth(38, context),
                                                  height:
                                                      getHeight(38, context),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Your friends get a discount off their first order.",
                                              style: TextStyle(
                                                fontSize:
                                                    getHeight(16, context),
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryGoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(16, context),
                                      ),
                                      SizedBox(
                                        // margin: const EdgeInsets.fromLTRB(0, 0, 11, 14),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 20, 0),
                                              width: getWidth(38, context),
                                              height: getHeight(38, context),
                                              child: SvgPicture.asset(
                                                'assets/shopping bag.svg',
                                                width: getWidth(38, context),
                                                height: getHeight(38, context),
                                              ),
                                            ),
                                            Text(
                                              "You get up to NGN 1000 for the first time your friend makes a delivery",
                                              style: TextStyle(
                                                fontSize:
                                                    getHeight(16, context),
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryGoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(14, context),
                                      ),
                                      Text(
                                        "Terms and Conditions",
                                        style: TextStyle(
                                          color: kPrimaryGoldColor,
                                          fontSize: getHeight(16, context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(19, context),
                                      ),
                                      Text(
                                        'Invite now using',
                                        style: TextStyle(
                                          color: kPrimaryGoldColor,
                                          fontSize: getHeight(16, context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(25, context),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 36, 0),
                                              width: getWidth(50, context),
                                              height: getHeight(50, context),
                                              child: SvgPicture.asset(
                                                  'assets/icon button.svg'),
                                            ),
                                            SizedBox(
                                              width: getWidth(36, context),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 36, 0),
                                              width: getWidth(50, context),
                                              height: getHeight(50, context),
                                              child: SvgPicture.asset(
                                                  'assets/icon button facebook.svg'),
                                            ),
                                            SizedBox(
                                              width: getHeight(36, context),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 36, 0),
                                              width: getWidth(50, context),
                                              height: getHeight(50, context),
                                              child: SvgPicture.asset(
                                                  'assets/messenger.svg'),
                                            ),
                                            SizedBox(
                                              width: getWidth(36, context),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 36, 0),
                                              width: getWidth(50, context),
                                              height: getHeight(50, context),
                                              child: SvgPicture.asset(
                                                  'assets/twitter.svg'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(20, context),
                                      ),
                                      Text(
                                        'Or copy your personal link',
                                        style: TextStyle(
                                          color: kPrimaryGoldColor,
                                          fontSize: getHeight(12, context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(15, context),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xfff2c94c)),
                                        ),
                                        child: Text(
                                          'goldline.com/me',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: getHeight(15, context),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
