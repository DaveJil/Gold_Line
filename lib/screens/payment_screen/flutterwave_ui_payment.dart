import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/api.dart';
import '../../utility/helpers/custom_button.dart';
import '../map/map_widget.dart';

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
                              print("optionIsCash is now $optionIsCash");
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
                              print("optionIsCash is now $optionIsCash");
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
                          : await makeCardPayment(
                              mapProvider.deliveryPrice.toString(),
                              mapProvider.deliveryId,
                            );
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

  Future makeCardPayment(String? price, int? deliveryId) async {
    final MapProvider mapProvider =
        Provider.of<MapProvider>(context, listen: false);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? email = preferences.getString("email");
    int randomInt = Random().nextInt(100);
    int refRandom = Random().nextInt(100000000000);


    final Customer customer = Customer(
        name: "user$randomInt", phoneNumber: "09$randomInt$randomInt$randomInt", email: email?? "user$randomInt@gmail.com");


    final flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK-fdc22eaae2024e22b7a5e34ca810bf9a-X",
        currency: "NGN",
        amount: price!,
        txRef: "trxGold${refRandom}Delivery",
        customer: customer,
        paymentOptions: "card, account, transfer",
        customization: Customization(),
        redirectUrl: 'www.google.com',
        isTestMode: false);

    final ChargeResponse flutterwaveResponse = await flutterwave.charge();
    bool success = flutterwaveResponse.success!;
    print(flutterwaveResponse);
    if (success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deliveryId = prefs.getString("deliveryId")!;
      String message = flutterwaveResponse.status!;
      print(flutterwaveResponse);

      print(message);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: "Transaction successful",
          message: "Your rider would be at pickup location in a moment",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      await CallApi()
          .postData(null, "user/delivery/verify-payment/$deliveryId");
      var response = await CallApi()
          .postData(null, "user/delivery/initialize-payment/$deliveryId");
      String code = response['code'];
      if(code == "success") {
        mapProvider.changeWidgetShowed(showWidget: Show.SEARCHING_FOR_DRIVER);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MapWidget()),
                (Route<dynamic> route) => false);
      }

    } else {
      print(flutterwaveResponse);

      String message = flutterwaveResponse.status!;
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: "Transaction unsuccessful",
          message: message,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Transaction Failed Try Again"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}
