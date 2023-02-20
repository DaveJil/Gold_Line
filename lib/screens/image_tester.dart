import 'package:flutter/material.dart';

class ImageTester extends StatelessWidget {
  const ImageTester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/markers/bike.png'),
      ),
    );
  }
}
