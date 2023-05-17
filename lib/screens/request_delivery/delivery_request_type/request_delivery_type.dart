import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/request_delivery/vans_delivery_details.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../delivery_details.dart';

class RequestDeliveryType extends StatefulWidget {
  const RequestDeliveryType({Key? key}) : super(key: key);

  @override
  State<RequestDeliveryType> createState() => _RequestDeliveryTypeState();
}

class _RequestDeliveryTypeState extends State<RequestDeliveryType> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGoldColor,
        title: Text("Select Delivery Type"),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.delivery_dining_outlined
              ),
              title: Text("Delivery Type 1"),
              subtitle: Text("Normal Delivery, Express Delivery, Inter-State , International Delivery"),
              onTap: () {
                changeScreen(context, DeliveryDetails());
              },
            ),
            ListTile(
              leading: Icon(
                  FontAwesomeIcons.truckPickup
              ),
              title: Text("Delivery Type 2"),
              subtitle: Text("Vans And Trucks"),
              onTap: () {
                changeScreen(context, VanDeliveryDetails());
              },
            )
          ],
        ),
      ),
    );
  }
}
