import 'package:flutter/material.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/providers/getTransactionHistory.dart';

import '../../../utility/helpers/routing.dart';

class WithdrawalScreen extends StatelessWidget {
  final TextEditingController amount = TextEditingController();
  final TextEditingController email = TextEditingController();

  WithdrawalScreen({super.key});

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
                  labelText: 'Enter amount you want to withdraw',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGoldColor
                ),
                onPressed: () {
                  withdraw(amount.text, context);
                },
                child: Text('Withdraw'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}