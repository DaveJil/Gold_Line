import 'package:flutter/widgets.dart';

double getHeight(double convertHeight, BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  const figmaDesignHeight = 926;
  double newScreenHeight = figmaDesignHeight / convertHeight;
  return screenHeight / newScreenHeight;
}

double getWidth(double convertWidth, BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  const figmaDesignWidth = 428;
  double newScreenWidth = figmaDesignWidth / convertWidth;
  return screenWidth / newScreenWidth;
}

double getFont(convertFont, BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  const figmaDesignWidth = 428;
  return (width / figmaDesignWidth) * convertFont;
}

extension getAppHeight on num {
  // convert height
  double appHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const figmaDesignHeight = 926;
    double newScreenHeight = figmaDesignHeight / toDouble();
    return screenHeight / newScreenHeight;
  }

  //  convert width
  double appWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaDesignWidth = 428;
    double newScreenWidth = figmaDesignWidth / toDouble();
    return screenWidth / newScreenWidth;
  }
}

double height(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  return height;
}

double width(BuildContext context) {
  final width = MediaQuery.of(context).size.height;
  return width;
}
