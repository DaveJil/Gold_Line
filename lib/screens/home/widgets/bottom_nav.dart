import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/screens/request_delivery/delivery_request_type/request_delivery_type.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../../../utility/helpers/constants.dart';
import '../../my_deliveries/select_type.dart';
import '../../profile/main_menu.dart';
import '../../request_delivery/delivery_details.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height / 10,
      width: double.infinity,
      color: kVistaWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: getWidth(10, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, MainMenu());
            },
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MainMenu()));
                      },
                      icon: Icon(
                        Icons.home_outlined,
                        color: kPrimaryGoldColor,
                        size: getHeight(40, context),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(5, context),
                  ),
                  AutoSizeText(
                    "Main Menu",
                    style: TextStyle(fontSize: getHeight(12, context)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: getWidth(2, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, DeliveryDetails());
            },
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RequestDeliveryType()));
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: kPrimaryGoldColor,
                        size: getHeight(40, context),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(5, context),
                  ),
                  AutoSizeText(
                    "New Booking",
                    style: TextStyle(fontSize: getHeight(12, context)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: getWidth(2, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, MyDeliveriesOptionScreen());
            },
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const MyDeliveriesOptionScreen()));
                      },
                      icon: Icon(
                        Icons.history,
                        color: kPrimaryGoldColor,
                        size: getHeight(40, context),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(10, context),
                  ),
                  AutoSizeText(
                    "My Bookings",
                    style: TextStyle(fontSize: getHeight(12, context)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: getWidth(10, context),
          ),
        ],
      ),
    );
  }
}
