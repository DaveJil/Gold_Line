import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/custom_button.dart';
import '../../utility/helpers/delivery_input.dart';

enum ProductSize { small, medium, large, multiple }

class ReceiverDeliveryDetails extends StatefulWidget {
  static const String iD = '/senderDeliveryScreen';

  const ReceiverDeliveryDetails({Key? key}) : super(key: key);

  @override
  ReceiverDeliveryDetailsState createState() => ReceiverDeliveryDetailsState();
}

class ReceiverDeliveryDetailsState extends State<ReceiverDeliveryDetails> {
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
                  "Receiver Details",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryGoldColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomDeliveryTextField(
                    hint: "Receiver Name", icon: Icon(Icons.person)),
                const SizedBox(
                  height: 12,
                ),
                const CustomDeliveryTextField(
                    hint: "Delivery Address", icon: Icon(Icons.home)),
                const SizedBox(
                  height: 12,
                ),
                const CustomDeliveryTextField(
                    hint: "Nearest Landmark", icon: Icon(Icons.location_on)),
                const SizedBox(
                  height: 12,
                ),
                const CustomDeliveryTextField(
                    hint: "Mobile Number", icon: Icon(Icons.phone)),
                const SizedBox(
                  height: 12,
                ),
                const CustomDeliveryTextField(
                    hint: "Special Instruction",
                    icon: Icon(Icons.question_mark)),
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
                  children: [
                    const Text(
                      "Delivery Options.",
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
                SizedBox(height: size.width / 15),
                const BuildDeliveryOption(),
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
            fontSize: 12,
            color: Colors.black54,
            // fontWeight: FontWeight.w400,
          ),
        ),
        Checkbox(
            value: _isFragile,
            onChanged: (bool? value) {
              setState(() {
                _isFragile = _isFragile;
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
  bool isSelected = false;
  bool isActive = true;

  void updateColor() {
    setState(() {
      isActive = !isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: updateColor,
            child: Card(
              elevation: 10,
              child: Container(
                height: 100,
                width: 100,
                color: isActive ? kVistaWhite : kPrimaryGoldColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Small"),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            child: ElevatedButton(
              onPressed: updateColor,
              style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? kVistaWhite : kPrimaryGoldColor,
                  elevation: 10),
              child: SizedBox(
                height: 100,
                width: 80,
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
          ),
          InkWell(
            onTap: updateColor,
            child: Card(
              elevation: 10,
              child: Container(
                height: 100,
                width: 100,
                color: isActive ? kVistaWhite : kPrimaryGoldColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 40,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Large"),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: updateColor,
            child: Card(
              elevation: 10,
              child: Container(
                height: 100,
                width: 100,
                color: isActive ? kVistaWhite : kPrimaryGoldColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.boxesStacked,
                      size: 30,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Multiple"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildDeliveryOption extends StatelessWidget {
  const BuildDeliveryOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          onPressed: () {},
          text: "Sender Pays",
          width: MediaQuery.of(context).size.width / 2.5,
        ),
        CustomButton(
          onPressed: () {},
          text: "Receiver Pays",
          width: MediaQuery.of(context).size.width / 2.5,
        )
      ],
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
          // uploadData();
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
                "Continue",
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
