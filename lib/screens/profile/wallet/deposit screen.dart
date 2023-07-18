import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/getTransactionHistory.dart';
import 'package:provider/provider.dart';

import '../../../utility/api_keys.dart';

final payStackPlugin = PaystackPlugin();

class DepositScreen extends StatefulWidget {

  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController amount = TextEditingController();

  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    payStackPlugin.initialize(publicKey: paystackPublicKey);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGoldColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            changeScreenReplacement(context, WalletScreen());
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: amount,
                decoration: InputDecoration(
                  labelText: 'Enter amount you want to deposit',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(

                onPressed: () {
                  // makePayStackPayment(amount.text, context);
                  // payWithPayStack(amount.text, context);
                  payStackDeposit(amount.text, context);
                },
                child: Text('Deposit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGoldColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}