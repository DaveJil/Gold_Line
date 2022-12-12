import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../utility/providers/map_provider.dart';
import '../../../utility/providers/user_provider.dart';

class PaymentMethodSelectionWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldState;

  const PaymentMethodSelectionWidget({Key? key, this.scaffoldState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.3,
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "How do you want to pay,\n\$${mapProvider.ridePrice}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                                width: 1.5)),
                        child: TextButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Method not available!")));
                            },
                            icon: const Icon(Icons.credit_card),
                            label: const Text("With Card")),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            border: Border.all(color: Colors.blue, width: 1.5)),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.monetization_on),
                            label: const Text("With Cash")),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                mapProvider.lookingForDriver
                    ? Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Container(
                          color: Colors.white,
                          child: const ListTile(
                            title: SpinKitWave(
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              mapProvider.requestDriver(
                                  distance:
                                      mapProvider.routeModel!.distance.toJson(),
                                  user: userProvider.userModel,
                                  lat: mapProvider.pickupCoordinates!.latitude,
                                  lng: mapProvider.pickupCoordinates!.longitude,
                                  context: context);
                              mapProvider.changeMainContext(context);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SpinKitWave(
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text("Looking for a driver"),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              LinearPercentIndicator(
                                                lineHeight: 4,
                                                animation: true,
                                                animationDuration: 100000,
                                                percent: 1,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.2),
                                                progressColor:
                                                    Colors.deepOrange,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        mapProvider
                                                            .cancelRequest();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Request cancelled!")));
                                                      },
                                                      child: const Text(
                                                          "Cancel Request",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepOrange))),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            style: TextButton.styleFrom(primary: Colors.black),
                            child: Text(
                              "Request",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        });
  }
}
