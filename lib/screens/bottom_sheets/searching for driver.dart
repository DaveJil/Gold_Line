import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/screens/my_deliveries/select_type.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/providers/map_provider.dart';
import '../../utility/services/calls_and_sms.dart';

class SearchingForDriverSheet extends StatefulWidget {
  SearchingForDriverSheet({Key? key}) : super(key: key);

  @override
  State<SearchingForDriverSheet> createState() =>
      _SearchingForDriverSheetState();
}

class _SearchingForDriverSheetState extends State<SearchingForDriverSheet> {
  Timer? _timer;

  final CallsAndMessagesService _service = CallsAndMessagesService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.1,
        maxChildSize: 0.55,
        builder: (BuildContext context, myScrollController) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryGoldColor,
                      offset: Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 40.appWidth(context),
                  vertical: 10.appHeight(context)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(10, context),
                    ),
                    AutoSizeText(
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
                        "A Rider/Driver will PICKUP within the hour.\nYou will be notified when the rider/driver is assigned to pick up\nCheck My Deliveries Page for delivery status and details of the rider/driver. \nOR Call 0813 896 9994 for Support",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 10.appHeight(context),
                    ),
                    SizedBox(
                      height: 50.appHeight(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              mapProvider.changeWidgetShowed(
                                  showWidget: Show.HOME);
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
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              changeScreenReplacement(
                                  context, MyDeliveriesOptionScreen());
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
            ),
          );
        });
  }
}
