import 'package:flutter/material.dart';

import 'constants.dart';

class CustomDeliveryTextField extends StatelessWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;
  final Function? onChanged;

  const CustomDeliveryTextField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.controller,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: kTextGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    onChanged;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 5, right: 5),
                    border: InputBorder.none,
                    fillColor: kTextGrey,
                    focusColor: kTextGrey,
                    hintText: hint,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
