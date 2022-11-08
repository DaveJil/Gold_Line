import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/widgets/map_widget.dart';

class GoldLine extends StatelessWidget {
  const GoldLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MapWidget(),
      theme: ThemeData(),
    );
  }
}
