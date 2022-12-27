import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
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
  final CallsAndMessagesService _service = CallsAndMessagesService();

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MapProvider mapProvider =
          Provider.of<MapProvider>(context, listen: false);
      mapProvider.checkDeliveryStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.8,
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
                  horizontal: 20.appWidth(context),
                  vertical: 10.appHeight(context)),
              child: ListView(
                controller: myScrollController,
                children: [
                  SizedBox(
                    height: getHeight(10, context),
                  ),
                  const Center(
                    child: AutoSizeText(
                      "Delivery Successfully Created",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryGoldColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  InkWell(
                    onTap: () {
                      mapProvider.checkDeliveryStatus();
                    },
                    child: const SpinKitDoubleBounce(
                      color: kPrimaryGoldColor,
                      size: 300,
                    ),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Center(
                    child: AutoSizeText(
                      "Searching for delivery rider",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 50.appHeight(context),
                      child: ElevatedButton(
                        onPressed: () {
                          mapProvider.cancelRequest();
                          mapProvider.changeWidgetShowed(showWidget: Show.HOME);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 20,
                          backgroundColor: Colors.white70,
                        ),
                        child: const Text(
                          "Cancel Delivery",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  AutoSizeText(
                      'Note that Cancellation Prices may apply depending on the circumstances.'),
                ],
              ),
            ),
          );
        });
  }
}
