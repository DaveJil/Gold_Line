import 'package:flutter/material.dart';
import 'package:gold_line/screens/splashscreen.dart';

class GoldLine extends StatelessWidget {
  const GoldLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(),
    );
  }
}
