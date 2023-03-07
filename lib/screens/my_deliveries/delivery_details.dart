import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/map_provider.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  final String? title;
  final String? pickUpLocation;
  final String? dropOffLocation;
  final String? description;
  final String? date;
  final String? price;
  final String? riderFirstName;
  final String? riderLastName;

  final String? riderPhoneNumber;
  final String? riderPlateNumber;
  final String? paymentMethod;
  final String? status;
  const DeliveryDetailsScreen(
      {Key? key,
      this.title,
      this.description,
      this.dropOffLocation,
      this.price,
      this.riderFirstName,
      this.riderLastName,
      this.riderPhoneNumber,
      this.riderPlateNumber,
      this.date,
      this.paymentMethod,
      this.status,
      this.pickUpLocation})
      : super(key: key);

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final deliveryListProvider =
        Provider.of<MapProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
        backgroundColor: kPrimaryGoldColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery #${widget.title}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Text(widget.date ?? "Today"),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Text("Pick Up Location: ${widget.pickUpLocation}"),
                  SizedBox(
                    height: 4.appHeight(context),
                  ),
                  Text("Drop Off Location: ${widget.dropOffLocation}"),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Text(
                    "Rider Details",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Text(
                      "Rider's Name: ${widget.riderFirstName!} ${widget.riderLastName!}"),
                  SizedBox(
                    height: 4.appHeight(context),
                  ),
                  Text("Rider's Phone Number: ${widget.riderPhoneNumber}"),
                  SizedBox(
                    height: 4.appHeight(context),
                  ),
                  Text("Bike Plate Number: ${widget.riderPlateNumber}"),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Text(
                    "Payment Details",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                  Text("Amount: ${widget.price}"),
                  SizedBox(
                    height: 4.appHeight(context),
                  ),
                  Text("Payment Method: ${widget.paymentMethod}"),
                  SizedBox(
                    height: 10.appHeight(context),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
