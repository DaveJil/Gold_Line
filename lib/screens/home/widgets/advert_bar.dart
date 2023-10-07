import 'package:flutter/material.dart';
import 'package:gold_line/screens/home/widgets/advert_container.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

class AdvertBar extends StatefulWidget {
  const AdvertBar({Key? key}) : super(key: key);

  @override
  State<AdvertBar> createState() => _AdvertBarState();
}

class _AdvertBarState extends State<AdvertBar> {
  List pages = [
    AdvertContainer(onPressed: () {}, backgroundImage: "assets/allshop.png"),
    AdvertContainer(onPressed: () {}, backgroundImage: "assets/areahire.png"),
    AdvertContainer(onPressed: () {}, backgroundImage: "assets/cinemo.png"),
  ];
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return SizedBox(
        height: 380.appHeight(context),
        width: double.infinity,
        child: PageView.builder(
            itemCount: pages.length,
            controller: PageController(
              initialPage: currentIndex,
            ),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return pages[index];
            }));
  }
}
