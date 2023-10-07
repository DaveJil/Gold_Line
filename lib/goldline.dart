import 'package:flutter/material.dart';
import 'package:gold_line/screens/home/home_screen.dart';
import 'package:gold_line/screens/splashscreen.dart';
import 'package:gold_line/utility/services/push_notifications.dart';
import 'package:provider/provider.dart';

import 'utility/providers/user_provider.dart';

class GoldLine extends StatefulWidget {
  const GoldLine({super.key});

  @override
  State<GoldLine> createState() => _GoldLineState();
}

class _GoldLineState extends State<GoldLine> {
  @override
  void initState() {
    // TODO: implement initState
    //////print("init");
    pushNotification.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return const SplashScreen();
      case Status.Unauthenticated:
        return const SplashScreen();
      case Status.Authenticated:
        return const HomeScreen();
      default:
        return const SplashScreen();
    }
  }
}
