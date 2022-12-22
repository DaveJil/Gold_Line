import 'package:flutter/material.dart';
import 'package:gold_line/components/appbar.dart';
import 'package:gold_line/components/cards.dart';
import 'package:gold_line/components/recentTransactions.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Appbar(),
              CardsList(),
              RecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}
