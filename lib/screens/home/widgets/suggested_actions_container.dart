import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

class SuggestedActionsContainer extends StatelessWidget {
  final String title;
  final Widget screen;
  final IconData icon;
  const SuggestedActionsContainer(
      {Key? key, required this.title, required this.screen, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            changeScreen(context, screen);
          },
          child: Container(
            height: 60.appHeight(context),
            width: 60.appWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]),
            child: Icon(
              icon,
              color: kPrimaryGoldColor,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          height: 10.appHeight(context),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[500]),
        )
      ],
    );
  }
}
