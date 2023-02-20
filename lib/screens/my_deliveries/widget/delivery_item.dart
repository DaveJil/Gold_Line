import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

class DeliveryItem extends StatelessWidget {
  final String Title;
  final String Date;
  final String price;
  final String? deliveryStatus;
  final String? description;

  DeliveryItem(
      {required this.Date,
      required this.Title,
      required this.deliveryStatus,
      required this.price,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: kPrimaryGoldColor,
            radius: 18,
            child: Icon(
              Icons.motorcycle_rounded,
              size: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 25.appWidth(context),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "#Devlivery-$Title",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                description!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                Date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Amount: ${price.toString()}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                deliveryStatus ?? 'Delivery cancel',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
