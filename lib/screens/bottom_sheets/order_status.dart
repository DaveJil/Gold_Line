import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/providers/map_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class OrderStatusWidget extends StatelessWidget {
  final CallsAndMessagesService? _service = CallsAndMessagesService();

  OrderStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        builder: (BuildContext context, myScrollController) {
          return Container(
            decoration: BoxDecoration(color: Colors.white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.8),
                      offset: const Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: myScrollController,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: mapProvider.deliveryCompleted == false
                              ? Text(
                                  "Your package is on it's way to ${receiverName.text}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              : const Text(
                                  'Your package has be delivered',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        "Order Status",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            mapProvider.changeWidgetShowed(
                                showWidget: Show.HOME);
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: kPrimaryGoldColor,
                            size: 50,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 30.appHeight(context),
                  ),
                  Text(
                    "Order number: ${mapProvider.deliveryId}",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.appHeight(context),
                  ),
                  SvgPicture.asset("assets/status_map.svg"),
                  SizedBox(
                    height: 30.appHeight(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                              child: Material(
                            color: kPrimaryGoldColor,
                            child: Icon(
                              FontAwesomeIcons.box,
                              size: 40,
                              color: Colors.white70,
                            ),
                          )),
                          Text(
                            "Delivery Created Sucessfully",
                            style: TextStyle(),
                          ),
                          Spacer(),
                          Icon(
                            FontAwesomeIcons.checkDouble,
                            color: Colors.green,
                          )
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Delivery price",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "\₦${mapProvider.deliveryPrice}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton(
                            onPressed: () {
                              mapProvider.updateDeliveryStatus();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryGoldColor),
                            child: const Text(
                              "Confirm Pick up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ElevatedButton(
                            onPressed: () {
                              mapProvider.cancelRequest();
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: const Text(
                              "Cancel Delivery",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
