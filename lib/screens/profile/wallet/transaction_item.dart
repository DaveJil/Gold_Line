import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionItem extends StatelessWidget {
  String? id;
  String? inOut;
  String? title;
  String? amount;
  String? orderId;
  String? createdAt;
  TransactionItem(
      {Key? key,
      this.id,
      this.inOut,
      this.title,
      this.createdAt,
      this.amount,
      this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    final screenWidth = MediaQuery.of(context).size.width;
    double getHeight(double convertHeight) {
      const figmaDesignHeight = 812;
      double newScreenHeight = figmaDesignHeight / convertHeight;
      return screenHeight / newScreenHeight;
    }

    double getWidth(double convertWidth) {
      const figmaDesignWidth = 375;
      double newScreenWidth = figmaDesignWidth / convertWidth;
      return screenWidth / newScreenWidth;
    }

    return Card(
      child: ListTile(
        leading: (inOut == "out")
            ? Icon(
                FontAwesomeIcons.download,
                color: Colors.red,
              )
            : Icon(
                FontAwesomeIcons.upload,
                color: Colors.green,
              ),
        title: Text("${title!}"),
        subtitle: Text(createdAt!),
        trailing: Text("₦$amount"),
      ),
    );
  }
}
