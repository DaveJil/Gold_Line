import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/home/widgets/advert_container.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

class AdvertBar extends StatefulWidget {
  const AdvertBar({Key? key}) : super(key: key);

  @override
  State<AdvertBar> createState() => _AdvertBarState();
}

class _AdvertBarState extends State<AdvertBar> {
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentPageIndex < 2) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 5000),
            curve: Curves.easeInOut);
      } else {
        // If on the last page, go back to the first page
        pageController.jumpToPage(0);
      }
    });
  }

  List pages = [
    AdvertContainer(onPressed: () {}, backgroundImage: "assets/cinemo.png"),
    AdvertContainer(onPressed: () {}, backgroundImage: "assets/allshop.png"),
    AdvertContainer(onPressed: () {}, backgroundImage: "assets/areahire.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 380.appHeight(context),
        width: double.infinity,
        child: PageView.builder(
            itemCount: pages.length,
            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return pages[index];
            }));
  }
}
