import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

class AdvertContainer extends StatelessWidget {
  final String backgroundImage;
  final void Function() onPressed;
  const AdvertContainer(
      {Key? key, required this.onPressed, required this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 380.appHeight(context),
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 90.appHeight(context),
              left: 30.appWidth(context),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ))
        ],
      ),
    );
  }
}
