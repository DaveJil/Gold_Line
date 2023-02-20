import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/providers/map_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class DriverFoundWidget extends StatefulWidget {
  DriverFoundWidget({Key? key}) : super(key: key);

  @override
  State<DriverFoundWidget> createState() => _DriverFoundWidgetState();
}

class _DriverFoundWidgetState extends State<DriverFoundWidget> {
  final CallsAndMessagesService? _service = CallsAndMessagesService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MapProvider mapProvider =
          Provider.of<MapProvider>(context, listen: false);
      mapProvider.getRiderDetails();
    });
    // TODO: implement initState
    super.initState();
  }

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
                        child: mapProvider.driverArrived == false
                            ? Text(
                                'Your delivery rider is on his way',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            : const Text(
                                'Your rider has arrived',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: mapProvider.driverName! + "\n",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ], style: const TextStyle(color: Colors.black))),
                    ],
                  ),
                  subtitle: ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.grey.withOpacity(0.5),
                    ),
                    onPressed: null,
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          children: [
                            TextSpan(text: "Rider Plate No:"),
                            TextSpan(text: mapProvider.driverPlate ?? "N?A")
                          ]),
                    ),
                  ),

                  // mapProvider.driverModel!.plate!,
                  //  + {mapProvider.driverPlate ?? "dr"} ,
                  // style:
                  //     const TextStyle(color: Colors.white, fontSize: 22),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        onPressed: () {
                          _service!
                              .call(mapProvider.driverPhone ?? "08138969994");
                        },
                        icon: const Icon(
                          Icons.call,
                        ),
                      )),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Ride details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 100,
                      width: 10,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Container(
                              height: 45,
                              width: 2,
                              color: kPrimaryGoldColor,
                            ),
                          ),
                          const Icon(Icons.flag),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "\nPick up location \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text: "${pickUpLocationController.text} \n\n\n",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                      const TextSpan(
                          text: "Destination \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text: "${dropOffLocationController.text} \n",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                    ], style: const TextStyle(color: Colors.black))),
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
                            // mapProvider.updateDeliveryStatus();
                            mapProvider.changeWidgetShowed(
                                showWidget: Show.ORDER_STATUS);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryGoldColor),
                          child: const Text(
                            "Confirm Pick up",
                            style: TextStyle(color: Colors.white, fontSize: 22),
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
                            mapProvider.changeWidgetShowed(
                                showWidget: Show.HOME);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text(
                            "Cancel Delivery",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
