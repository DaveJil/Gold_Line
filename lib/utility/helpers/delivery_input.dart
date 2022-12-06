import 'package:flutter/material.dart';

import 'constants.dart';

class CustomDeliveryTextField extends StatefulWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;
  final Function? onChanged;
  final FocusNode? focusNode;

  const CustomDeliveryTextField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.controller,
      this.focusNode,
      this.onChanged})
      : super(key: key);

  @override
  State<CustomDeliveryTextField> createState() =>
      _CustomDeliveryTextFieldState();
}

class _CustomDeliveryTextFieldState extends State<CustomDeliveryTextField> {
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
              widget.icon,
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  style: const TextStyle(fontSize: 18),
                  focusNode: widget.focusNode,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 5, right: 5),
                    border: InputBorder.none,
                    fillColor: kTextGrey,
                    focusColor: kTextGrey,
                    hintText: widget.hint,
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
