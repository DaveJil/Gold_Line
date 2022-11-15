import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/constants.dart';

import '../../utility/helpers/custom_button.dart';

class CheckoutDelivery extends StatefulWidget {
  // final String price;
  // final String id;

  const CheckoutDelivery({
    Key? key,

    // required this.price, required this.id
    //
  }) : super(key: key);

  @override
  State<CheckoutDelivery> createState() => _CheckoutDeliveryState();
}

class _CheckoutDeliveryState extends State<CheckoutDelivery> {
  @override
  Widget build(BuildContext context) {
    // DeliveryProvider deliveryProvider = DeliveryProvider();
    // DeliveryModel deliveryModel = DeliveryModel(id: widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CHeckOut",
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
              "Recipient:",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text('''
            Eze Evidence
            07014261561
            40G CoolPark Avenue
           ''', style: TextStyle(fontSize: 20)),
            const Text("Parcel Details:", style: TextStyle(fontSize: 22)),
            const SizedBox(
              height: 7,
            ),
            const Text('''
           Delivery Status: Pending
           Delivery Address: OAU campus   
           Sender Pays
           ''', style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: CustomButton(
                height: 60,
                fontSize: 22,
                onPressed: () async {
                  // await deliveryProvider.initializeDeliveryPayment(context);
                },
                text: "Pay 5000",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
