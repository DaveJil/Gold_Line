import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/my_deliveries/interstate/widget/accepted_deliveries.dart';
import 'package:gold_line/screens/my_deliveries/interstate/widget/cancelled_deliveries.dart';
import 'package:gold_line/screens/my_deliveries/interstate/widget/completed_deliveries.dart';
import 'package:gold_line/screens/my_deliveries/interstate/widget/pending_deliveries.dart';

import '../../../utility/helpers/constants.dart';

class MyInterStateDeliveriesScreen extends StatefulWidget {
  const MyInterStateDeliveriesScreen({Key? key}) : super(key: key);

  @override
  State<MyInterStateDeliveriesScreen> createState() =>
      _MyInterStateDeliveriesScreenState();
}

class _MyInterStateDeliveriesScreenState
    extends State<MyInterStateDeliveriesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryGoldColor,
          bottom: TabBar(
            indicatorWeight: 5,
            indicatorColor: Colors.blueGrey,
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.stackExchange),
                text: "Pending",
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.list),
                text: "Accepted",
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.listCheck),
                text: "Completed",
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.ban),
                text: "Cancelled",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PendingDeliveries(),
            AcceptedDeliveries(),
            CompletedDeliveries(),
            CancelledDeliveries()
          ],
        ),
      ),
    );
  }
}
