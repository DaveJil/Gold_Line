import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';

class SplashScreen extends StatefulWidget {
  static const String iD = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadScreen();
  }

  void loadScreen() {
    _timer = Timer(const Duration(seconds: 3), goNext);
  }

  goNext() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          //margin: const EdgeInsets.only(top: 150),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/logo.svg'),
        ),
      ),
    );
  }
}
