import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/screens/splashscreen.dart';
import 'package:provider/provider.dart';

import 'utility/providers/user_provider.dart';

class GoldLine extends StatelessWidget {
  const GoldLine({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return const SplashScreen();
      case Status.Unauthenticated:
        return SplashScreen();
      case Status.Authenticated:
        return const MapWidget();
      default:
        return SplashScreen();
    }
  }
}
