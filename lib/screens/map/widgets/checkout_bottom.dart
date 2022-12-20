import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/controllers.dart';
import '../../../utility/helpers/custom_button.dart';
import '../../../utility/providers/map_provider.dart';
import '../../../utility/providers/user_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class SummaryWidget extends StatelessWidget {
  final CallsAndMessagesService? _service = CallsAndMessagesService();

  SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.05,
        maxChildSize: 0.8,
        builder: (BuildContext context, myScrollController) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
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
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  controller: myScrollController,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Summary",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
                    const Text("Parcel Details:",
                        style: TextStyle(fontSize: 22)),
                    const SizedBox(
                      height: 7,
                    ),
                    Text('''
             Delivery Status: Pending
             PickUp Address: ${pickUpLocation.text}  
             Delivery Address: ${dropOffLocation.text}  
             Sender Pays
             ''', style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 7,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                          height: 60,
                          fontSize: 22,
                          onPressed: () async {
                            mapProvider.changeWidgetShowed(
                                showWidget: Show.FLUTTERWAVE_PAYMENT);
                          },
                          text: "Proceed to pay ₦${mapProvider.deliveryPrice}",
                        ),
                      ),
                    ),
                    Text(
                        'Note that this price is an estimated price. Price may differ after delivery.'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
