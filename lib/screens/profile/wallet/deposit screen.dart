import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/getTransactionHistory.dart';

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
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            changeScreenReplacement(context, const WalletScreen());
          },
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                  labelText: 'Enter amount you want to deposit',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // makePayStackPayment(amount.text, context);
                  // payWithPayStack(amount.text, context);
                  payStackDeposit(amount.text, context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGoldColor),
                child: Text('Deposit'),
              ),
              const SizedBox(height: 20.0),
              const Text(
                  "Wallet Top Ups  may encounter delays due to bank network. Ensure you don't quit the paystack checkout until transaction is successful. Contact support for any issues/complaints regarding this")
            ],
          ),
        ),
      ),
    );
  }
}
