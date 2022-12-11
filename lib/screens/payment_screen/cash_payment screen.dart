import 'package:flutter/material.dart';

import '../../utility/helpers/constants.dart';

TextEditingController fullNameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryDateController = TextEditingController();
TextEditingController cvvController = TextEditingController();

class CashPaymentScreen extends StatefulWidget {
  static const String iD = '/paymentScreen';
  const CashPaymentScreen({Key? key}) : super(key: key);

  @override
  _CashPaymentScreenState createState() => _CashPaymentScreenState();
}

class _CashPaymentScreenState extends State<CashPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryGoldColor,
      appBar: AppBar(
        backgroundColor: kPrimaryGoldColor,
        elevation: 0,
        title: const Text(
          "Cash Payments",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: const Center(
        child: Text("Await Driver To Confirm Payment"),
      ),
    );
  }
}
