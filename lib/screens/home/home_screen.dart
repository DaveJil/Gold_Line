import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/home/widgets/advert_bar.dart';
import 'package:gold_line/screens/home/widgets/suggested_actions_container.dart';
import 'package:gold_line/screens/profile/settings_page.dart';
import 'package:gold_line/screens/profile/supportScreen.dart';
import 'package:gold_line/screens/profile/wallet/deposit%20screen.dart';
import 'package:gold_line/screens/profile/wallet/inter_wallet_transfer_screen.dart';
import 'package:gold_line/screens/request_delivery/delivery_details.dart';
import 'package:gold_line/screens/request_delivery/inter_city_ride_details.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  final LatLng? pickupLatLng;
  final LatLng? dropoffLatLng;

  const HomeScreen({Key? key, this.pickupLatLng, this.dropoffLatLng})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AdvertBar(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.appWidth(context),
                          vertical: 20.appHeight(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Suggested Actions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20.appHeight(context),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SuggestedActionsContainer(
                                screen: InterWalletTransferScreen(),
                                title: "Transfer",
                                icon: FontAwesomeIcons.wallet,
                              ),
                              SuggestedActionsContainer(
                                screen: Settings(),
                                title: "Edit Profile",
                                icon: FontAwesomeIcons.userAstronaut,
                              ),
                              SuggestedActionsContainer(
                                screen: SupportScreen(),
                                title: "Contact Us",
                                icon: FontAwesomeIcons.phone,
                              ),
                              SuggestedActionsContainer(
                                screen: DepositScreen(),
                                title: "Top up",
                                icon: FontAwesomeIcons.creditCard,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.appHeight(context),
                          ),
                          const Text(
                            "Quick Actions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20.appHeight(context),
                          ),
                          InkWell(
                            onTap: () {
                              changeScreen(context, const DeliveryDetails());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.appHeight(context),
                                  horizontal: 10.appWidth(context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffFFB8B8).withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset("assets/homedispatch.svg"),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Send a package",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                          softWrap: true,
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 8.appHeight(context),
                                        ),
                                        const Text(
                                          "Have a rider deliver or pick up a package for  you across town ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.appHeight(context),
                          ),
                          InkWell(
                            onTap: () {
                              changeScreen(
                                  context, const InterCityRideDetails());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.appHeight(context),
                                  horizontal: 10.appWidth(context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffFFB8B8).withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset("assets/homeride.svg"),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Order Inter city Ride",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                          softWrap: true,
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 8.appHeight(context),
                                        ),
                                        const Text(
                                          "Travel from one state to another with ease. From your doorstep to your destination.",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ), // ANCHOR Draggable
              const Align(
                  alignment: Alignment.bottomCenter, child: BottomNav()),
              // ANCHOR PICK UP WIDGET
            ],
          ),
        ),
      ),
    );
  }
}
