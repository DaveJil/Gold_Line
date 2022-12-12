import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/helpers/custom_button.dart';

class CheckoutDelivery extends StatefulWidget {
  final LatLng? pickupLatLng;
  final LatLng? dropoffLatLng;
  const CheckoutDelivery({Key? key, this.pickupLatLng, this.dropoffLatLng

      // required this.price, required this.id
      //
      })
      : super(key: key);
  @override
  State<CheckoutDelivery> createState() => _CheckoutDeliveryState();
}

class _CheckoutDeliveryState extends State<CheckoutDelivery> {
  String? checkoutSenderPhone;

  @override
  Widget build(BuildContext context) {
    // DeliveryProvider deliveryProvider = DeliveryProvider();
    // DeliveryModel deliveryModel = DeliveryModel(id: widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CheckOut Delivery",
          style: TextStyle(
            color: kPrimaryGoldColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
          color: kPrimaryGoldColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sender Details",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 7,
            ),
            Text('''
            ${senderName.text}
            ${senderPhone.text}            
                       ''', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Receiver",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 7,
            ),
            Text('''
            ${receiverName.text}
            ${receiverPhone.text}            
             ''', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            const Text("Parcel Details:", style: TextStyle(fontSize: 22)),
            const SizedBox(
              height: 7,
            ),
            Text('''
           Delivery Status: Pending
           PickUp Address: ${pickUpLocation.text}  
           Delivery Address: ${dropOffLocation.text}  
           Sender Pays
           ''', style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: CustomButton(
                height: 60,
                fontSize: 22,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MapWidget(
                                pickupLatLng: widget.pickupLatLng,
                                dropoffLatLng: widget.dropoffLatLng,
                              )));
                },
                text: "Pay 5000",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    checkoutSenderPhone = preferences.getString("senderPhone")!;
  }
}
