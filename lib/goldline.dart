import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/trip_screen.dart';

class GoldLine extends StatefulWidget {
  const GoldLine({Key? key}) : super(key: key);

  @override
  State<GoldLine> createState() => _GoldLineState();
}

class _GoldLineState extends State<GoldLine> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestMapWidget(),
      theme: ThemeData(),
    );
  }
}
