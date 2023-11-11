import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/custom_button.dart';
import '../../utility/providers/getTransactionHistory.dart';

class FlutterwavePaymentScreen extends StatefulWidget {
  static const String iD = '/paymentScreen';
  final GlobalKey<ScaffoldState>? scaffoldState;
  const FlutterwavePaymentScreen({Key? key, this.scaffoldState})
      : super(key: key);

  @override
  FlutterwavePaymentScreenState createState() =>
      FlutterwavePaymentScreenState();
}

class FlutterwavePaymentScreenState extends State<FlutterwavePaymentScreen> {
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
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(9),
                  color: paymentProvider.orderPaymentMethod ==
                          OrderPaymentMethod.cash
                      ? kPrimaryGoldColor
                      : Colors.white),
              width: size.width,
              height: 60,
              child: ListTile(
                onTap: () {
                  setState(() {
                    paymentProvider.setTransactionsTypeEnum =
                        OrderPaymentMethod.cash;
                  });
                },
                contentPadding: const EdgeInsets.only(left: 20),
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
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(width: 0.5, color: Colors.grey[400]!),
                  color: paymentProvider.orderPaymentMethod ==
                          OrderPaymentMethod.card
                      ? kPrimaryGoldColor
                      : Colors.white),
              width: size.width,
              height: 60,
              child: ListTile(
                onTap: () {
                  setState(() {
                    paymentProvider.setTransactionsTypeEnum =
                        OrderPaymentMethod.card;
                  });
                },
                contentPadding: const EdgeInsets.only(left: 20),
                minVerticalPadding: 5,
                leading: Icon(FontAwesomeIcons.globe, color: Colors.black),
                minLeadingWidth: 5,
                title: const Text(
                  "Paystack",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(width: 0.5, color: Colors.grey[400]!),
                  color: paymentProvider.orderPaymentMethod ==
                          OrderPaymentMethod.wallet
                      ? kPrimaryGoldColor
                      : Colors.white),
              width: size.width,
              height: 60,
              child: ListTile(
                onTap: () {
                  setState(() {
                    paymentProvider.setTransactionsTypeEnum =
                        OrderPaymentMethod.wallet;
                  });
                },
                contentPadding: const EdgeInsets.only(left: 20),
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
              ),
            ),
            SizedBox(
              height: 50.appHeight(context),
            ),
            CustomButton(
              onPressed: () async {
                if (paymentProvider.orderPaymentMethod ==
                    OrderPaymentMethod.cash) {
                  print(paymentProvider.orderPaymentMethod);

                  await mapProvider.updatePaymentMethod(
                      "cash", "cash", context);
                  await mapProvider.submitCashDelivery(context);
                }

                if (paymentProvider.orderPaymentMethod ==
                    OrderPaymentMethod.card) {
                  print(paymentProvider.orderPaymentMethod);
                  await mapProvider.updatePaymentMethod(
                      "card", "paystack", context);

                  payStackDelivery(
                      mapProvider.deliveryPrice.toString(), context);
                }
                if (paymentProvider.orderPaymentMethod ==
                    OrderPaymentMethod.wallet) {
                  print(paymentProvider.orderPaymentMethod);

                  final payment = await mapProvider.updatePaymentMethod(
                      "wallet", "wallet", context);
                  if (payment == true) {
                    await mapProvider.submitWalletDelivery(context);
                  }
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
