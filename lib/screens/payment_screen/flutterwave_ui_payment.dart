import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/api.dart';
import '../../utility/helpers/custom_button.dart';

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
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
                                  print("optionIsCash is now $optionIsCash");
                                }),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  minVerticalPadding: 5,
                                  leading: const Icon(
                                      FontAwesomeIcons.moneyBill1,
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
                                  print("optionIsCash is now $optionIsCash");
                                }),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  minVerticalPadding: 5,
                                  leading: const Icon(
                                      FontAwesomeIcons.creditCard,
                                      color: Colors.black),
                                  minLeadingWidth: 5,
                                  title: const Text(
                                    "Pay With Card",
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
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      optionIsCash
                          ? mapProvider.changeWidgetShowed(
                              showWidget: Show.CASH_PAYMENT)
                          : makeCardPayment(
                              mapProvider.deliveryPrice.toString(),
                              mapProvider.deliveryId);
                    },
                    text: "Pay",
                    fontSize: 20,
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

  void makeCardPayment(String? price, int? deliveryId) async {
    final Customer customer = Customer(
        name: "user", phoneNumber: "0000000000", email: "user@gmail.com");
    final flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK-fdc22eaae2024e22b7a5e34ca810bf9a-X",
        currency: "NGN",
        amount: "100",
        txRef: "GoldLine#$deliveryId",
        customer: customer,
        paymentOptions: "card, account, transfer",
        customization: Customization(),
        redirectUrl: 'www.google.com',
        isTestMode: false);

    final ChargeResponse response = await flutterwave.charge();
    if (response == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Transaction Failed Try Again"),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deliveryId = prefs.getString("deliveryId")!;
      if (response.status == "success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Transaction Successful"),
          backgroundColor: Colors.green,
        ));
        await CallApi().postData(null, "user/trip/verify-payment/$deliveryId");

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const MapWidget()),
        //     (Route<dynamic> route) => false);
      }
    }
  }
}
