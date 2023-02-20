import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/my_deliveries/widget/completed_deliveries.dart';
import 'package:gold_line/screens/my_deliveries/widget/pending_deliveries.dart';

import '../../utility/helpers/constants.dart';

class MyDeliveriesScreen extends StatefulWidget {
  const MyDeliveriesScreen({Key? key}) : super(key: key);

  @override
  State<MyDeliveriesScreen> createState() => _MyDeliveriesScreenState();
}

class _MyDeliveriesScreenState extends State<MyDeliveriesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryGoldColor,
          bottom: TabBar(
            indicatorWeight: 5,
            indicatorColor: Colors.blueGrey,
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.list),
                text: "Pending",
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.listCheck),
                text: "Completed",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [PendingDeliveries(), CompletedDeliveries()],
        ),
      ),
    );
  }
}
