import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../../../utility/helpers/constants.dart';
import '../../my_deliveries/my_deliveries.dart';
import '../../profile/main_menu.dart';
import '../../request_delivery/delivery_details.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
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
                      icon: const Icon(
                        Icons.home_outlined,
                        color: kPrimaryGoldColor,
                        size: 35,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  const Text(
                    "Main Menu",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10.appWidth(context),
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
                                builder: (_) => const DeliveryDetails()));
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: kPrimaryGoldColor,
                        size: 35,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  const Text(
                    "New Delivery",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10.appWidth(context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, MyDeliveriesScreen());
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
                                builder: (_) => const MyDeliveriesScreen()));
                      },
                      icon: const Icon(
                        Icons.history,
                        color: kPrimaryGoldColor,
                        size: 35,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: height / 25,
                  ),
                  const AutoSizeText(
                    "My Deliveries",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
