import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold_line/screens/my_deliveries/widget/pending_deliveries.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/helpers/custom_button.dart';
import '../../../utility/providers/get_list_provider.dart';
import '../../../utility/providers/map_provider.dart';
import '../delivery_details.dart';

class NewDeliveryCard extends StatelessWidget {
  final String? title;
  final String? pickUpLocation;
  final String? dropOffLocation;
  final String? description;
  final String? id;

  const NewDeliveryCard(
      {Key? key,
      this.title,
      this.description,
      this.dropOffLocation,
      this.id,
      this.pickUpLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deliveryListProvider =
        Provider.of<GetListProvider>(context, listen: false);

    return Card(
      elevation: 20,
      child: Container(
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
                "Delivery #$title",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Text("Pick Up Location: $pickUpLocation"),
              SizedBox(
                height: 4.appHeight(context),
              ),
              Text("Drop Off Location: $dropOffLocation"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      deliveryListProvider.cancelDelivery(context, id!);
                    },
                    child: Text("Reject"),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), backgroundColor: Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryCard extends StatefulWidget {
  final String? title;
  final int? id;
  final String? type;
  final String? price;
  final String? status;
  final String? pickUpLocation;
  final String? dropOffLocation;
  final String? description;
  final String? riderFirstName,
      riderLastName,
      riderPhoneNumber,
      riderPlateNumber;
  final String? pickUpLatitude,
      pickUpLongitude,
      dropOffLatitude,
      dropOffLongitude;
  final String? date;
  final String? paymentMethod, paymentBy, paymentStatus;
  final String? receiverName;
  final String? receiverPhone;
  final String? senderName;
  final String? senderPhone;
  final List? children;

  const DeliveryCard(
      {Key? key,
      this.title,
      this.status,
      this.price,
      this.type,
      this.id,
      this.senderPhone,
      this.senderName,
      this.receiverPhone,
      this.receiverName,
      this.description,
      this.dropOffLocation,
      this.pickUpLocation,
      this.riderPlateNumber,
      this.riderLastName,
      this.riderPhoneNumber,
      this.riderFirstName,
      this.dropOffLatitude,
      this.dropOffLongitude,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.paymentBy,
      this.paymentMethod,
      this.paymentStatus,
      this.children,
      this.date})
      : super(key: key);

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    final deliveryListProvider =
        Provider.of<GetListProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        changeScreen(
            context,
            DeliveryDetailsScreen(
              title: widget.title,
              description: widget.description,
              dropOffLocation: widget.dropOffLocation,
              pickUpLocation: widget.pickUpLocation,
              price: widget.price,
              riderFirstName: widget.riderFirstName,
              riderLastName: widget.riderLastName,
              riderPhoneNumber: widget.riderPhoneNumber,
              riderPlateNumber: widget.riderPlateNumber,
              date: widget.date,
              paymentMethod: widget.paymentMethod,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery #${widget.title}",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 4.appHeight(context),
            ),
            Text("Pick Up Location: ${widget.pickUpLocation}"),
            SizedBox(
              height: 4.appHeight(context),
            ),
            Text("Drop Off Location: ${widget.dropOffLocation}"),
            SizedBox(
              height: 4.appHeight(context),
            ),
            Text("Description: ${widget.description}"),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Text("Amount: ₦${widget.price!}"),
                  SizedBox(
                    height: 4.appHeight(context),
                  ),
                  Text("Status: ${widget.status!}"),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        showCupertinoDialog(
                            context: context,
                            builder: (_) {
                              return CupertinoAlertDialog(
                                title: Text("Confirm Pick Up"),
                                content: Text(
                                    "Click Confirm to confirm that rider has picked up your package"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text("CONFIRM"),
                                    onPressed: () {
                                      deliveryListProvider.confirmPickUp(
                                          context, widget.title);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("CANCEL"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text("Confirm Pick Up"),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: kPrimaryGoldColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: kPrimaryGoldColor,
                                          offset: Offset(3, 2),
                                          blurRadius: 7)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ListView(
                                    children: [
                                      Row(
                                        children: const [
                                          Text(
                                            'Why Do you Want to Cancel',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      addRadioButton(0, "Rider did not move"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      addRadioButton(
                                          1, "Rider asked to cancel"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      addRadioButton(
                                          2, 'Wrong pickup location'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      addRadioButton(3,
                                          'Receiver does not need the package anymore'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      addRadioButton(4, "Long Pickup time"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Other Reasons:"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        maxLines: 3,
                                        controller: deliveryListProvider
                                            .cancelDescription,
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueGrey,
                                                  width: 1.0),
                                            ),
                                            hintText: "Kindly tell us"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomButton(
                                          color: Colors.redAccent,
                                          onPressed: () {
                                            print(widget.title);
                                            deliveryListProvider.cancelDelivery(
                                                context,
                                                widget.title.toString());
                                          },
                                          text: "Cancel")
                                    ],
                                  ),
                                ),
                              );
                            });
                        // deliveryListProvider.cancelDelivery(
                        //     context, id!.toString());
                      },
                      child: Text("Cancel Delivery"),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), backgroundColor: Colors.red),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  List reason = [
    'rider_did_not_move',
    'rider_asked_to_cancel',
    'wrong_pickup_location',
    'receiver_do_not_need_package_anymore',
    'long_pickup_time',
    'other'
  ];

  Row addRadioButton(int btnValue, String title) {
    GetListProvider reasonProvider = Provider.of<GetListProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 18,
          height: MediaQuery.of(context).size.width / 18,
          decoration: BoxDecoration(
              color: reasonProvider.rideCancelReason == reason[btnValue]
                  ? kPrimaryGoldColor
                  : Colors.white,
              border: Border.all(
                color: kPrimaryGoldColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) =>
                reasonProvider.rideCancelReason == reason[btnValue]
                    ? kPrimaryGoldColor
                    : Colors.white),
            activeColor: kPrimaryGoldColor,
            value: reason[btnValue],
            groupValue: reasonProvider.rideCancelReason,
            onChanged: (value) {
              reasonProvider.rideCancelReason = value;
              setState(() {
                print(value);
                reasonProvider.rideCancelReason = value;
              });
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ))
      ],
    );
  }
}

class CompletedDeliveryCard extends StatefulWidget {
  final String? title;
  final int? id;
  final String? type;
  final String? price;
  final String? status;
  final String? pickUpLocation;
  final String? dropOffLocation;
  final String? description;
  final String? riderFirstName,
      riderLastName,
      riderPhoneNumber,
      riderPlateNumber;
  final String? pickUpLatitude,
      pickUpLongitude,
      dropOffLatitude,
      dropOffLongitude;
  final String? date;
  final String? paymentMethod, paymentBy, paymentStatus;
  final String? receiverName;
  final String? receiverPhone;
  final String? senderName;
  final String? senderPhone;
  final List? children;

  const CompletedDeliveryCard(
      {Key? key,
      this.title,
      this.status,
      this.price,
      this.type,
      this.id,
      this.senderPhone,
      this.senderName,
      this.receiverPhone,
      this.receiverName,
      this.description,
      this.dropOffLocation,
      this.pickUpLocation,
      this.riderPlateNumber,
      this.riderLastName,
      this.riderPhoneNumber,
      this.riderFirstName,
      this.dropOffLatitude,
      this.dropOffLongitude,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.paymentBy,
      this.paymentMethod,
      this.paymentStatus,
      this.children,
      this.date})
      : super(key: key);

  @override
  State<CompletedDeliveryCard> createState() => _CompletedDeliveryCardState();
}

class _CompletedDeliveryCardState extends State<CompletedDeliveryCard> {
  @override
  Widget build(BuildContext context) {
    final deliveryListProvider =
        Provider.of<MapProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        (widget.type == "bulk")
            ? changeScreen(context, PendingDeliveries())
            : changeScreen(
                context,
                DeliveryDetailsScreen(
                  title: widget.title,
                  description: widget.description,
                  dropOffLocation: widget.dropOffLocation,
                  pickUpLocation: widget.pickUpLocation,
                  price: widget.price,
                  riderFirstName: widget.riderFirstName,
                  riderLastName: widget.riderLastName,
                  riderPhoneNumber: widget.riderPhoneNumber,
                  riderPlateNumber: widget.riderPlateNumber,
                  date: widget.date,
                  paymentMethod: widget.paymentMethod,
                  paymentBy: widget.paymentBy,
                  paymentStatus: widget.paymentStatus,
                  pickUpLatitude: widget.pickUpLatitude,
                  pickUpLongitude: widget.pickUpLongitude,
                  dropOffLatitude: widget.dropOffLatitude,
                  dropOffLongitude: widget.dropOffLongitude,
                  senderPhone: widget.senderPhone,
                  senderName: widget.senderName,
                  receiverPhone: widget.receiverPhone,
                  receiverName: widget.receiverName,
                ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                color: kPrimaryGoldColor,
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.type ?? "Single",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            Text(
              "Delivery #${widget.title}",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 4.appHeight(context),
            ),
            Text("Pick Up Location: ${widget.pickUpLocation}"),
            SizedBox(
              height: 4.appHeight(context),
            ),
            Text("Drop Off Location: ${widget.dropOffLocation}"),
            SizedBox(
              height: 4.appHeight(context),
            ),
            Text("Description: ${widget.description}"),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Text("Amount: ₦${widget.price!}"),
                  SizedBox(
                    height: 4.appHeight(context),
                  ),
                  Text("Status: ${widget.status!}"),
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
