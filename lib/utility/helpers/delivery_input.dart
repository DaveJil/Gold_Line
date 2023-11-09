import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

import 'constants.dart';

class CustomDeliveryTextField extends StatefulWidget {
  final String hint;
  final Widget? icon;
  final TextEditingController controller;
  final Function? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomDeliveryTextField(
      {Key? key,
      required this.hint,
      this.icon,
      required this.controller,
      this.validator,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 10.appWidth(context), vertical: 5.appHeight(context)),
          child: Row(
            children: [
              widget.icon ?? SizedBox(),
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
                  validator: widget.validator,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.black12,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5.appWidth(context)),
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
