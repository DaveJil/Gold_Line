import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/providers/map_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class DriverFoundWidget extends StatelessWidget {
  final CallsAndMessagesService? _service = CallsAndMessagesService();

  DriverFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.05,
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
                                'Your ride arrives in ${mapProvider.routeModel!.timeNeeded.toString()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            : const Text(
                                'Your ride has arrived',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: Container(
                    child: mapProvider.driverModel?.photo == null
                        ? const CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.person_outline,
                              size: 25,
                            ),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(mapProvider.driverModel!.photo!),
                          ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: mapProvider.driverModel!.first_name! + "\n",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: mapProvider.driverModel!.car,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300)),
                      ], style: const TextStyle(color: Colors.black))),
                    ],
                  ),
                  subtitle: ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.grey.withOpacity(0.5),
                      ),
                      onPressed: null,
                      child: Text(
                        mapProvider.driverModel!.plate!,
                        style: const TextStyle(color: Colors.white),
                      )),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        onPressed: () {
                          _service!.call(mapProvider.driverModel!.phone!);
                        },
                        icon: const Icon(Icons.call),
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
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "\nPick up location \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text: "25th avenue, flutter street \n\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                      TextSpan(
                          text: "Destination \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text: "25th avenue, flutter street \n",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                    ], style: TextStyle(color: Colors.black))),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Ride price",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "\$${mapProvider.ridePrice}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text(
                      "Cancel Ride",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
