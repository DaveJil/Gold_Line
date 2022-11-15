import 'package:flutter/material.dart';
import 'package:gold_line/screens/multiple_delivery/multiple_delivery.dart';
import 'package:gold_line/screens/request_delivery/sender_details.dart';

import '../my_deliveries/my_deliveries.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List pages = const [
    MyDeliveriesScreen(),
    SenderDeliveryDetails(),
    MultipleDelivery(),
  ];

  int _currentPage = 0;
  void onTap(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    final screenWidth = MediaQuery.of(context).size.width;
    double getHeight(double convertHeight) {
      const figmaDesignHeight = 812;
      double newScreenHeight = figmaDesignHeight / convertHeight;
      return screenHeight / newScreenHeight;
    }

    double getWidth(double convertWidth) {
      const figmaDesignWidth = 375;
      double newScreenWidth = figmaDesignWidth / convertWidth;
      return screenWidth / newScreenWidth;
    }

    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedFontSize: getHeight(15),
          unselectedFontSize: getHeight(15),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentPage,
          elevation: 30,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                //
                icon: Icon(
                  Icons.home_rounded,
                  size: getHeight(32),
                  // color: Colors.black,
                ),
                label: 'My Deliveries'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  size: getHeight(24),
                  // color: Colors.black,
                ),
                label: 'New Delivery'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.schedule_send_rounded,
                  size: getHeight(32),
                  // color: Colors.black,
                ),
                label: 'Multiple Deliveries'),
          ]),
    );
  }
}
