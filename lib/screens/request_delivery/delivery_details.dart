import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/request_delivery/select_location.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/delivery_input.dart';

enum ProductSize { small, medium, large, multiple }

class DeliveryDetails extends StatefulWidget {
  static const String iD = '/senderDeliveryScreen';

  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  DeliveryDetailsState createState() => DeliveryDetailsState();
}

class DeliveryDetailsState extends State<DeliveryDetails> {
  bool onTapped = false;

  bool value = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // deliveryProvider.disposeSenderDetails();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: kPrimaryGoldColor,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Delivery Details",
          style: TextStyle(
              color: kVistaWhite, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: size.width / 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Specify Delivery Details",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryGoldColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDeliveryTextField(
                  hint: "Sender Name",
                  icon: const Icon(Icons.person),
                  controller: senderName,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Sender Phone Number",
                  icon: const Icon(Icons.phone),
                  controller: senderPhone,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Receiver Name",
                  icon: const Icon(Icons.person),
                  controller: receiverName,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Receiver Mobile Number",
                  icon: const Icon(Icons.phone),
                  controller: receiverPhone,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Package Description",
                  icon: const Icon(Icons.description),
                  controller: receiverPhone,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Special Instruction",
                  icon: const Icon(Icons.question_mark),
                  controller: instruction,
                ),
                const SizedBox(height: 7),
                const BuildCheckBox(),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const Text(
                      "Size Of Item.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                const BuildItemSize(),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: const [
                    Text(
                      "Delivery Options.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 20),
                    PayerRadioButton()
                  ],
                ),
                SizedBox(height: size.width / 15),
                const BuildContinueButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildCheckBox extends StatefulWidget {
  const BuildCheckBox({Key? key}) : super(key: key);

  @override
  State<BuildCheckBox> createState() => _BuildCheckBoxState();
}

class _BuildCheckBoxState extends State<BuildCheckBox> {
  bool _isFragile = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Please tick if this parcel is considered as fragile",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black54,
            // fontWeight: FontWeight.w400,
          ),
        ),
        Checkbox(
            value: _isFragile,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                _isFragile = !_isFragile;
              });
            })
      ],
    );
  }
}

class BuildItemSize extends StatefulWidget {
  const BuildItemSize({Key? key}) : super(key: key);

  @override
  State<BuildItemSize> createState() => _BuildItemSizeState();
}

class _BuildItemSizeState extends State<BuildItemSize> {
  bool isSmall = true;
  bool isMedium = true;
  bool isLarge = true;
  bool isMultiple = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(150, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                isSmall = !isSmall;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: isSmall ? kVistaWhite : kPrimaryGoldColor,
                elevation: 10),
            child: SizedBox(
              height: getHeight(100, context),
              width: getWidth(80, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.boxOpen,
                    size: 20,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Small",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isMedium = !isMedium;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: isMedium ? kVistaWhite : kPrimaryGoldColor,
                elevation: 10),
            child: SizedBox(
              height: getHeight(100, context),
              width: getWidth(80, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.boxOpen,
                    size: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Medium",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLarge = !isLarge;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: isLarge ? kVistaWhite : kPrimaryGoldColor,
                elevation: 10),
            child: SizedBox(
              height: getHeight(100, context),
              width: getWidth(80, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.boxOpen,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Large",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isMultiple = !isMultiple;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: isMultiple ? kVistaWhite : kPrimaryGoldColor,
                elevation: 10),
            child: SizedBox(
              height: getHeight(100, context),
              width: getWidth(80, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.boxesStacked,
                    size: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Multiple",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildContinueButton extends StatelessWidget {
  const BuildContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => SelectLocationScreen()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 20,
          decoration: BoxDecoration(
            color: kPrimaryGoldColor,
            border: Border.all(),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Set Delivery Location",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PayerRadioButton extends StatefulWidget {
  const PayerRadioButton({Key? key}) : super(key: key);

  @override
  State<PayerRadioButton> createState() => _PayerRadioButtonState();
}

class _PayerRadioButtonState extends State<PayerRadioButton> {
  List payer = [
    "sender",
    "receiver",
  ];

  String? select;
  // int btnValue;
  // String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildPayerOption(0, "Sender Pays"),
        const SizedBox(
          width: 20,
        ),
        buildPayerOption(1, "Receiver Pays")
      ],
    );
  }

  Widget buildPayerOption(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 18,
          height: MediaQuery.of(context).size.width / 18,
          decoration: BoxDecoration(
              color:
                  select == payer[btnValue] ? kPrimaryGoldColor : Colors.white,
              border: Border.all(
                color: kPrimaryGoldColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) =>
                select == payer[btnValue] ? kPrimaryGoldColor : Colors.white),
            activeColor: Theme.of(context).primaryColor,
            value: payer[btnValue],
            groupValue: select,
            onChanged: (value) async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              setState(() {
                print(value);
                select = value;
                pref.setString('PAYER', select!);
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
