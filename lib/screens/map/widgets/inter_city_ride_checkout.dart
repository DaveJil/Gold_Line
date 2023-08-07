import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/controllers.dart';
import '../../../utility/helpers/custom_button.dart';
import '../../../utility/helpers/dimensions.dart';
import '../../../utility/providers/map_provider.dart';
import '../../../utility/providers/user_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class InterCityRideSummaryWidget extends StatelessWidget {
  final CallsAndMessagesService? _service = CallsAndMessagesService();

  InterCityRideSummaryWidget({Key? key}) : super(key: key);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: kPrimaryGoldColor,
                            size: getHeight(24, context),
                          ),
                        ),
                        Text(
                          "Summary",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: kPrimaryGoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.send_and_archive,
                          color: Colors.grey,
                          size: getHeight(24, context),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          "Booking Personal Details",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    AutoSizeText('''
                Name: ${interCityBookingName.text}
                Phone: ${interCityBookingPhone.text}  
                Number of seats: ${interCityBookingNumberOfSeats.text}        
                           ''',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.call_received,
                          color: Colors.grey,
                          size: getHeight(24, context),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        const AutoSizeText(
                          "Other Details",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    AutoSizeText('''
                Luggage Size: ${receiverName.text}
                Departure Date: ${mapProvider.selectedBookingDate}
                Departure Time: ${mapProvider.departureTimeDownDownValue}
                Booking Type: ${mapProvider.interCityBookingType}            
                 ''', style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                          height: 60,
                          fontSize: 18,
                          onPressed: () async {
                            mapProvider.changeWidgetShowed(
                                showWidget: Show.FLUTTERWAVE_PAYMENT);
                          },
                          text: "Proceed to pay ₦${mapProvider.deliveryPrice}",
                        ),
                      ),
                    ),
                    AutoSizeText(
                        'Note that this price is an estimated price. Price may differ after delivery.'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
