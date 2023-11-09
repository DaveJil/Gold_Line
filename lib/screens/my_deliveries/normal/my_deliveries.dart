import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utility/helpers/constants.dart';
import 'widget/accepted_deliveries.dart';
import 'widget/cancelled_deliveries.dart';
import 'widget/completed_deliveries.dart';
import 'widget/pending_deliveries.dart';

class MyDeliveriesScreen extends StatefulWidget {
  const MyDeliveriesScreen({Key? key}) : super(key: key);

  @override
  State<MyDeliveriesScreen> createState() => _MyDeliveriesScreenState();
}

class _MyDeliveriesScreenState extends State<MyDeliveriesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryGoldColor,
          bottom: const TabBar(
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
        body: const TabBarView(
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
