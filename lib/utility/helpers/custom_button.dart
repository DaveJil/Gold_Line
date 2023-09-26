import 'package:flutter/material.dart';

import 'constants.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? elevation;
  final Color shadowColor;

  const CustomButton(
      {Key? key,
      this.color,
      this.width,
      this.height,
      this.fontSize,
      this.elevation,
      this.shadowColor = Colors.black,
      required this.onPressed,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? kPrimaryGoldColor,
            shape: const StadiumBorder(),
            elevation: elevation),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }
}
