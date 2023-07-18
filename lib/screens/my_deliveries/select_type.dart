import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/components/select_type_card.dart';
import 'package:gold_line/screens/my_deliveries/interstate/my_deliveries.dart';
import 'package:gold_line/screens/my_deliveries/vans_and_trucks/my_deliveries.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../../../utility/helpers/constants.dart';
import 'international/my_deliveries.dart';
import 'normal/my_deliveries.dart';

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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: getHeight(20, context),
          color: kPrimaryGoldColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AutoSizeText(
          'Choose Delivery Option',
          style: TextStyle(
            color: kPrimaryGoldColor,
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
            'You will see the delivery history for \nthe selected delivery type',
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
          InkWell(
            onTap: () {
              changeScreen(context, MyDeliveriesScreen());
            },

            child: ListTile(
              tileColor: Colors.white70,
              title: Text('Normal Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(Icons.delivery_dining),
            ),
          ),
          SizedBox(
            height: getHeight(20, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, MyInterStateDeliveriesScreen());
            },
            child: ListTile(
              tileColor: Colors.white70,
              title: Text('Inter-State Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(Icons.delivery_dining_outlined),
            ),
          ),

          SizedBox(
            height: getHeight(20, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, MyInternationalDeliveriesScreen());
            },
            child: ListTile(
              tileColor: Colors.white70,
              title: Text('International Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(Icons.airplanemode_active),
            ),
          ),

          SizedBox(
            height: getHeight(20, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, const MyVansDeliveriesScreen());
            },
            child: ListTile(
              tileColor: Colors.white70,
              title: Text('Vans And Trucks',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(FontAwesomeIcons.truckPickup),
            ),
          ),

          SizedBox(
            height: getHeight(20, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, const MyVansDeliveriesScreen());
            },
            child: ListTile(
              tileColor: Colors.white70,
              title: Text('Vans And Trucks',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(FontAwesomeIcons.truckPickup),
            ),
          ),
          SizedBox(
            height: getHeight(20, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, const MyVansDeliveriesScreen());
            },
            child: ListTile(
              tileColor: Colors.white70,
              title: Text('Vans And Trucks',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(FontAwesomeIcons.truckPickup),
            ),
          ),
          SizedBox(
            height: getHeight(20, context),
          ),
          InkWell(
            onTap: () {
              changeScreen(context, const MyVansDeliveriesScreen());
            },
            child: ListTile(
              tileColor: Colors.white70,
              title: Text('Inter City Rides',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              leading: const Icon(FontAwesomeIcons.car),
            ),
          ),
        ],
      ),
    );
  }
}
