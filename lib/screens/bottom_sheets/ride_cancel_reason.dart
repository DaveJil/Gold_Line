import 'package:flutter/material.dart';
import 'package:safedrop_user/helpers/constants.dart';

import '../../utility/provider/map_provider/map_provider.dart';
import '../button.dart';

class RideCancelReason extends StatefulWidget {
  const RideCancelReason({Key? key}) : super(key: key);

  @override
  State<RideCancelReason> createState() => _RideCancelReasonState();
}

class _RideCancelReasonState extends State<RideCancelReason> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.05,
        maxChildSize: 0.8,
        builder: (BuildContext context, myScrollController) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryBlueColor,
                      offset: Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView(
                controller: myScrollController,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  addRadioButton(1, "Rider asked to cancel"),
                  const SizedBox(
                    height: 10,
                  ),
                  addRadioButton(2, 'Wrong pickup location'),
                  const SizedBox(
                    height: 10,
                  ),
                  addRadioButton(3, "Long Pickup time"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Other Reasons:"),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        hintText: "Kindly tell us"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        MapProvider mapProvider = MapProvider();
                        mapProvider.cancelTrip(select!);
                      },
                      text: "Cancel")
                ],
              ),
            ),
          );
        });
  }

  List reason = [
    "Driver did Not move",
    "Driver asked to cancel",
    "Wrong Pickup Location",
    "Long Pick-up time",
  ];

  String? select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 18,
          height: MediaQuery.of(context).size.width / 18,
          decoration: BoxDecoration(
              color:
                  select == reason[btnValue] ? kPrimaryBlueColor : Colors.white,
              border: Border.all(
                color: kPrimaryBlueColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) =>
                select == reason[btnValue] ? kPrimaryBlueColor : Colors.white),
            activeColor: Theme.of(context).primaryColor,
            value: reason[btnValue],
            groupValue: select,
            onChanged: (value) {
              setState(() {
                print(value);
                select = value;
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
