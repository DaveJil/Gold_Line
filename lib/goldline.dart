import 'package:flutter/material.dart';
import 'package:gold_line/screens/request_delivery/delivery_summary.dart';

class GoldLine extends StatelessWidget {
  const GoldLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckoutDelivery(),
      theme: ThemeData(),
    );
  }
}
