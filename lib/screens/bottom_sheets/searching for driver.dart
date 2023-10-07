import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/home/home_screen.dart';
import 'package:gold_line/screens/my_deliveries/select_type.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../../utility/helpers/constants.dart';

class SearchingForDriver extends StatefulWidget {
  const SearchingForDriver({Key? key}) : super(key: key);

  @override
  State<SearchingForDriver> createState() => _SearchingForDriverState();
}

class _SearchingForDriverState extends State<SearchingForDriver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 40.appWidth(context), vertical: 10.appHeight(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(10, context),
            ),
            SizedBox(
              child: SvgPicture.asset("assets/homedispatch.svg"),
            ),
            const AutoSizeText(
              "Delivery Created Successfully..",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: kPrimaryGoldColor,
              ),
            ),
            SizedBox(
              height: 10.appHeight(context),
            ),
            Center(
              child: SizedBox(
                height: 100.appHeight(context),
                child: Image.asset("assets/tick.png"),
              ),
            ),
            SizedBox(
              height: 10.appHeight(context),
            ),
            const Center(
              child: Text(
                "A Rider/Driver will PICKUP within the hour/at selcted departure time.\nYou will be notified when the rider/driver is assigned to pick up\nCheck My Deliveries Page for delivery status and details of the rider/driver. \nOR Call 0813 896 9994 for Support",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10.appHeight(context),
            ),
            SizedBox(
              height: 50.appHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      removeScreenUntil(context, HomeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 20,
                      backgroundColor: kPrimaryGoldColor,
                    ),
                    child: const Text(
                      "Home",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changeScreenReplacement(
                          context, const MyDeliveriesOptionScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 20,
                      backgroundColor: Colors.white70,
                    ),
                    child: const Text(
                      "My Deliveries",
                      style: TextStyle(
                          color: kPrimaryGoldColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.appHeight(context),
            ),
            const AutoSizeText(
                'Note that Cancellation Prices may apply depending on the circumstances.'),
            const AutoSizeText(
                'Check for delivery status updates on "My Deliveries" option.')
          ],
        ),
      ),
    );
  }
}
