import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utility/helpers/constants.dart';
import '../../../../utility/helpers/custom_button.dart';
import '../../../../utility/providers/get_list_provider.dart';

class RideCancelReason extends StatefulWidget {
  const RideCancelReason({Key? key}) : super(key: key);

  @override
  State<RideCancelReason> createState() => _RideCancelReasonState();
}

class _RideCancelReasonState extends State<RideCancelReason> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: kPrimaryGoldColor, offset: Offset(3, 2), blurRadius: 7)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView(
          children: [
            const Row(
              children: [
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
            addRadioButton(3, 'Receiver does not need the package anymore'),
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
                  // MapProvider mapProvider = MapProvider();
                  // mapProvider.cancelTrip(select!);
                },
                text: "Cancel")
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
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Radio<String>(
            fillColor: WidgetStateColor.resolveWith((states) =>
                reasonProvider.rideCancelReason == reason[btnValue]
                    ? kPrimaryGoldColor
                    : Colors.white),
            activeColor: Theme.of(context).primaryColor,
            value: reason[btnValue],
            groupValue: reasonProvider.rideCancelReason,
            onChanged: (value) {
              reasonProvider.rideCancelReason = value;
              setState(() {
                //print(value);
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
