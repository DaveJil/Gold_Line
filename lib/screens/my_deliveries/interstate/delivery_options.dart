import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

import '../../../utility/helpers/constants.dart';

class MyDeliveriesOptionScreen extends StatefulWidget {
  const MyDeliveriesOptionScreen({Key? key}) : super(key: key);

  @override
  State<MyDeliveriesOptionScreen> createState() => _MyDeliveriesOptionScreen();
}

class _MyDeliveriesOptionScreen extends State<MyDeliveriesOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGoldColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: getHeight(20, context),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AutoSizeText(
          'Choose Delivery Option',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: getHeight(20, context),
          ),
          AutoSizeText(
            'You will see the delivery history for \n the selected delivery type',
            style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.w400,
              fontSize: getHeight(16, context),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(40, context),
          ),
          Material(
            child: CheckboxListTile(
              tileColor: Colors.white70,
              title: Text('Normal Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              value: false,
              onChanged: (bool? value) {},
              secondary: const Icon(Icons.delivery_dining),
            ),
          ),
          SizedBox(
            height: getHeight(20, context),
          ),
          Material(
            child: CheckboxListTile(
              tileColor: Colors.white70,
              title: Text('Express Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              value: false,
              onChanged: (bool? value) {},
              secondary: const Icon(Icons.bike_scooter),
            ),
          ),
          SizedBox(
            height: getHeight(20, context),
          ),
          Material(
            child: CheckboxListTile(
              tileColor: Colors.white70,
              title: Text('Inter-State Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              value: false,
              onChanged: (bool? value) {},
              secondary: const Icon(Icons.airplanemode_active),
            ),
          ),
        ],
      ),
    );
  }
}
