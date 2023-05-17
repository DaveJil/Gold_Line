import 'package:flutter/material.dart';
import 'package:gold_line/utility/providers/getTransactionHistory.dart';
import 'package:provider/provider.dart';

class DepositScreen extends StatelessWidget {
  final TextEditingController amount = TextEditingController();
  final TextEditingController email = TextEditingController();

  DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  makeCardPayment(amount.text, context);
                },
                child: Text('Deposit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}