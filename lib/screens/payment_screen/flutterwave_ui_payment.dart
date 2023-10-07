import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider = Provider.of<MapProvider>(context);
    final OrderPaymentProvider paymentProvider =
        Provider.of<OrderPaymentProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30.appWidth(context), vertical: 100.appHeight(context)),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Select Payment Method",
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
              height: size.height / 16,
              child: InkWell(
                onTap: (() {
                  setState(() {
                    paymentProvider.setTransactionsTypeEnum =
                        OrderPaymentMethod.cash;
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
                      size: 30,
                      color: paymentProvider.orderPaymentMethod ==
                              OrderPaymentMethod.cash
                          ? Colors.blue
                          : Colors.black38),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 16,
              child: InkWell(
                onTap: (() {
                  setState(() {
                    paymentProvider.setTransactionsTypeEnum =
                        OrderPaymentMethod.card;
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
                  trailing: Icon(Icons.circle,
                      size: 30,
                      color: paymentProvider.orderPaymentMethod ==
                              OrderPaymentMethod.card
                          ? Colors.blue
                          : Colors.black38),
                ),
              ),
            ),

            SizedBox(
              width: size.width,
              height: size.height / 16,
              child: InkWell(
                onTap: (() {
                  setState(() {
                    paymentProvider.setTransactionsTypeEnum =
                        OrderPaymentMethod.wallet;
                  });
                  //////print("optionIsCash is now $optionIsCash");
                }),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 5, bottom: 20),
                  minVerticalPadding: 5,
                  leading:
                      const Icon(FontAwesomeIcons.wallet, color: Colors.black),
                  minLeadingWidth: 5,
                  title: const Text(
                    "Wallet",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.circle,
                      size: 30,
                      color: paymentProvider.orderPaymentMethod ==
                              OrderPaymentMethod.wallet
                          ? Colors.blue
                          : Colors.black38),
                ),
              ),
            ),
            SizedBox(
              height: 50.appHeight(context),
            ),
            CustomButton(
              onPressed: () async {
                if (paymentProvider.orderPaymentMethod ==
                    OrderPaymentMethod.cash) {
                  await mapProvider.updatePaymentMethod(
                      "cash", "cash", context);
                  await mapProvider.submitCashDelivery();
                }

                if (paymentProvider.orderPaymentMethod ==
                    OrderPaymentMethod.card) {
                  await mapProvider.updatePaymentMethod(
                      "card", "paystack", context);

                  payStackDelivery(
                      mapProvider.deliveryPrice.toString(), context);
                }
                if (paymentProvider.orderPaymentMethod ==
                    OrderPaymentMethod.wallet) {
                  await mapProvider.updatePaymentMethod(
                      "wallet", "wallet", context);
                }
              },
              text: "Pay",
              fontSize: 18,
              width: size.width / 2.5,
              height: size.height * 0.06,
              elevation: 8,
            ),

            //
          ],
        ),
      ),
    ));
  }
}
