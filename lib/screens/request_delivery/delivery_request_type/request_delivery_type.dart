import 'package:flutter/material.dart';
import 'package:gold_line/screens/request_delivery/inter_city_ride_details.dart';
import 'package:gold_line/screens/request_delivery/multiple_delivery_details.dart';
import 'package:gold_line/screens/request_delivery/vans_delivery_details.dart';
import 'package:gold_line/utility/helpers/custom_display_widget.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../../../components/select_type_card.dart';
import '../delivery_details.dart';

class RequestDeliveryType extends StatefulWidget {
  const RequestDeliveryType({Key? key}) : super(key: key);

  @override
  State<RequestDeliveryType> createState() => _RequestDeliveryTypeState();
}

class _RequestDeliveryTypeState extends State<RequestDeliveryType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Select Booking Type",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.appWidth(context)),
          child: ListView(
            children: [
              SelectTypeCard(
                titleText:
                    "Dispatch Bikes, InterState,\nInternational Delivery",
                subText:
                    "Get Good and Packages from one\nplace to another now ",
                image: "assets/dispatch.svg",
                onTap: () {
                  changeScreen(context, DeliveryDetails());
                },
              ),
              SizedBox(
                height: 21.appHeight(context),
              ),
              SelectTypeCard(
                titleText: "Multiple Dispatch Delivery",
                subText:
                    "Send Goods from one place to\ndifferent locations now on the\n Goldline app.",
                image: "assets/multipledispatch.svg",
                onTap: () {
                  changeScreen(context, MultipleDeliveryDetails());
                },
              ),
              SizedBox(
                height: 21.appHeight(context),
              ),
              SelectTypeCard(
                titleText: "Vans And Trucks",
                subText:
                    "Request Vans and Trucks here, make\nyour request, offer your price and\nconnect to the best offer available for\nyour need ",
                image: "assets/vans_svg.svg",
                onTap: () {
                  changeScreen(context, VanDeliveryDetails());
                },
              ),
              SizedBox(
                height: 21.appHeight(context),
              ),
              SelectTypeCard(
                titleText: "Order Rides",
                subText:
                    "Wanna Move from place to place, get\nthis done by using Goldline Ride\n Services ",
                image: "assets/ride.svg",
                onTap: () {
                  CustomDisplayWidget.displayAwesomeNotificationSnackBar(
                      context, "Coming Soon", "Coming soon");
                },
              ),
              SizedBox(
                height: 21.appHeight(context),
              ),
              SelectTypeCard(
                titleText: "Inter City Rides",
                subText:
                    "Request Inter City Rides from one\ncity to another at your ease, from\nyour location to another.",
                image: "assets/inter_city.svg",
                onTap: () {
                  changeScreen(context, InterCityRideDetails());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
