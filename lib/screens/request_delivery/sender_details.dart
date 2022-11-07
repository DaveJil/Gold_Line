import 'package:flutter/material.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/custom_button.dart';
import '../../utility/helpers/delivery_input.dart';

class SenderDeliveryDetails extends StatefulWidget {
  static const String iD = '/senderDeliveryScreen';

  const SenderDeliveryDetails({Key? key}) : super(key: key);

  @override
  _SenderDeliveryDetailsState createState() => _SenderDeliveryDetailsState();
}

class _SenderDeliveryDetailsState extends State<SenderDeliveryDetails> {
  bool onTapped = false;

  bool value = false;

  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final landmarkFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final instructionFocusNode = FocusNode();
  final cityFocusNode = FocusNode();

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
        elevation: 0,
        backgroundColor: kPrimaryGoldColor,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: kPrimaryGoldColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Delivery Details",
          style: TextStyle(
              color: kPrimaryGoldColor,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width / 14, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sender Details",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomDeliveryTextField(
                  hint: "Sender Name", icon: Icon(Icons.person)),
              const SizedBox(
                height: 12,
              ),
              const CustomDeliveryTextField(
                  hint: "Address", icon: Icon(Icons.home)),
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
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "Item Details.",
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
                height: 12,
              ),
              const CustomDeliveryTextField(
                  hint: "Item Description", icon: Icon(Icons.gif_box_rounded)),
              const SizedBox(
                height: 12,
              ),
              const CustomDeliveryTextField(
                  hint: "Special Instruction", icon: Icon(Icons.question_mark)),
              const SizedBox(height: 7),
              const BuildCheckBox(),
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
              BuildContinueButton()
            ],
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

class BuildDeliveryOption extends StatelessWidget {
  const BuildDeliveryOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          onPressed: () {},
          text: "Instant\nDelivery",
          width: MediaQuery.of(context).size.width / 2.5,
        ),
        CustomButton(
          onPressed: () {},
          text: "Scheduled\nDelivery",
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
