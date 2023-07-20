import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/custom_button.dart';
import '../../utility/providers/getTransactionHistory.dart';

class FlutterwavePaymentScreen extends StatefulWidget {
  static const String iD = '/paymentScreen';
  final GlobalKey<ScaffoldState>? scaffoldState;
  FlutterwavePaymentScreen({Key? key, this.scaffoldState}) : super(key: key);

  @override
  _FlutterwavePaymentScreenState createState() =>
      _FlutterwavePaymentScreenState();
}

class _FlutterwavePaymentScreenState extends State<FlutterwavePaymentScreen> {
  bool optionIsCash = false;

  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider = Provider.of<MapProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.1,
        maxChildSize: 0.8,
        builder: (BuildContext context, myScrollController) {
          return Container(
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
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 14,
                        vertical: size.height / 80),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Payment Methods",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height / 80),
                        SizedBox(
                          width: size.width,
                          height: size.height / 19,
                          child: InkWell(
                            onTap: (() {
                              setState(() {
                                optionIsCash = true;
                              });
                              //////print("optionIsCash is now $optionIsCash");
                            }),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 5),
                              minVerticalPadding: 5,
                              leading: const Icon(FontAwesomeIcons.moneyBill1,
                                  color: Colors.black),
                              minLeadingWidth: 5,
                              title: const Text(
                                "Cash",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Icon(Icons.circle,
                                  color: optionIsCash
                                      ? Colors.blue
                                      : Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height / 19,
                          child: InkWell(
                            onTap: (() {
                              setState(() {
                                optionIsCash = false;
                              });
                              //////print("optionIsCash is now $optionIsCash");
                            }),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 5),
                              minVerticalPadding: 5,
                              leading: const Icon(FontAwesomeIcons.creditCard,
                                  color: Colors.black),
                              minLeadingWidth: 5,
                              title: const Text(
                                "Card/Bank Transfer",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_circle_right,
                                  color: optionIsCash
                                      ? Colors.black38
                                      : Colors.blue),
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                  CustomButton(
                    onPressed: () async {
                      optionIsCash
                          ? await mapProvider.submitCashDelivery()
                          : payStackDelivery(
                              mapProvider.deliveryPrice.toString(), context);
                    },
                    text: "Pay",
                    fontSize: 18,
                    width: size.width / 2.5,
                    height: size.height * 0.06,
                    elevation: 8,
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        });
  }
}
