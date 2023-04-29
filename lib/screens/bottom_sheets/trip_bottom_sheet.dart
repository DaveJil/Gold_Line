import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/controllers.dart';
import '../../utility/providers/map_provider.dart';
import '../../utility/services/calls_and_sms.dart';

class TripBottomSheet extends StatelessWidget {
  final CallsAndMessagesService _service = CallsAndMessagesService();

  TripBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.05,
        maxChildSize: 0.8,
        builder: (BuildContext context, myScrollController) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryGoldColor,
                      offset: Offset(3, 2),
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
                        child: const Text(
                      'ON TRIP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    )),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: Container(
                    child: mapProvider.driverProfile?.phone == null
                        ? const CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.person_outline,
                              size: 25,
                            ),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                mapProvider.driverProfile!.avatar!),
                          ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text:
                                mapProvider.driverProfile!.profile!.firstName! +
                                    "\n",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: mapProvider.driverProfile!.profile!.rideType,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300)),
                      ], style: const TextStyle(color: Colors.black))),
                    ],
                  ),
//                  subtitle: RaisedButton(
//                      color: Colors.white.withOpacity(.9),
//                      onPressed: (){},
//                      child: CustomText(
//                        text: "End Trip",
//                        color: red,
//                      )),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info,
                          color: kVistaWhite,
                        ),
                      )),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Delivery details",
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
                    SizedBox(
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
                          "Ride price",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "\$${mapProvider.deliveryPrice}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text("END MY TRIP",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }
}
