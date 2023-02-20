import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/widgets/cardInPage.dart';
import 'package:gold_line/widgets/otherDetailsDivider.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: getWidth(5, context),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: getHeight(20, context),
                    color: kPrimaryGoldColor,
                  ),
                  SizedBox(
                    width: getWidth(15, context),
                  ),
                  AutoSizeText(
                    "Wallet Balance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: getWidth(310, context),
                  ),
                  Icon(
                    Icons.history,
                    color: Colors.blue,
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Available Balance',
                style: TextStyle(
                  color: Color(0xFF938E8E),
                  fontSize: getFont(20, context),
                ),
              ),
              SizedBox(
                height: getHeight(20, context),
              ),
              Text(
                '₦ 0.00',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getFont(60, context),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: getHeight(20, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getHeight(40, context),
                          vertical: getWidth(10, context)),
                      height: getHeight(47, context),
                      width: getWidth(170, context),
                      decoration: BoxDecoration(
                        color: kPrimaryGoldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: getWidth(10, context),
                          ),
                          Text(
                            'Fund',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getFont(20, context),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: "Coming Soon",
                          message:
                              "You would soon be able to deposit and receive money from referrals",
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
                    width: getWidth(20, context),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getHeight(24, context),
                          vertical: getWidth(10, context)),
                      height: getHeight(47, context),
                      width: getWidth(170, context),
                      decoration: BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.download_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: getWidth(10, context),
                          ),
                          Text(
                            'Withdraw',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getFont(20, context),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: "Coming Soon",
                          message:
                              "You would soon be able to withdraw and receive money from referrals to your bank Account",
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
                ],
              ),
              SizedBox(
                height: getHeight(60, context),
              ),
              Text(
                'Transaction History',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: getFont(20, context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: getHeight(60, context),
              ),
              CardInPage(
                  color: kPrimaryGoldColor,
                  letter: 'Nil',
                  price: '₦ 0.0000',
                  subTitle: 'Fund Wallet to Begin',
                  title: 'No Transactions Done'),
              OtherDetailsDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
