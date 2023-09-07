import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/getTransactionHistory.dart';

import '../../../utility/api_keys.dart';

final payStackPlugin = PaystackPlugin();

class InterWalletTransferScreen extends StatefulWidget {
  const InterWalletTransferScreen({super.key});

  @override
  State<InterWalletTransferScreen> createState() =>
      _InterWalletTransferScreenState();
}

class _InterWalletTransferScreenState extends State<InterWalletTransferScreen> {
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
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Recipient's email address",
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                  labelText: 'Enter transfer amount',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  interWalletTransfer(amount.text, email.text, context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGoldColor),
                child: const Text('Transfer'),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
