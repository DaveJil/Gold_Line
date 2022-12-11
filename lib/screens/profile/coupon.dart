import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/profile/referral.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

import '../my_deliveries/my_deliveries.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold
      (
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
            color: kPrimaryGoldColor,
            iconSize: getHeight(16, context),
            onPressed:(){
              Navigator.pop(context);
            },
        ),
        title: Text('My Coupons',
        style: TextStyle(
          color: Colors.black,
          fontSize: getHeight(28, context),
          fontWeight: FontWeight.w600,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: getWidth(500, context),
          height: getHeight(400, context),
          child: Text("No Coupons Yet",
          style:
          TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: getHeight(20, context),
          ),),
        ),

      ),
    ),);
  }
}
