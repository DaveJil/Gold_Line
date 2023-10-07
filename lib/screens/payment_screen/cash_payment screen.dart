import 'package:flutter/material.dart';
import 'package:gold_line/screens/bottom_sheets/searching%20for%20driver.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/custom_button.dart';
import '../../../utility/providers/map_provider.dart';
import '../../../utility/providers/user_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class CashPaymentWidget extends StatelessWidget {
  final CallsAndMessagesService? _service = CallsAndMessagesService();

  CashPaymentWidget({Key? key}) : super(key: key);

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
              decoration: BoxDecoration(
                  color: Colors.white,
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
                    const Center(
                      child: Text(
                        "Cash Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                        "You will pay ₦${mapProvider.deliveryPrice} to the Rider on arrival"),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                          height: 60,
                          fontSize: 18,
                          onPressed: () async {
                            changeScreenReplacement(
                                context, SearchingForDriver());
                          },
                          text: "Continue",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
