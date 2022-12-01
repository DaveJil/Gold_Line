import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:google_place/google_place.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/custom_button.dart';
import '../../utility/helpers/delivery_input.dart';
import 'receiver_details.dart';

class SenderDeliveryDetails extends StatefulWidget {
  static const String iD = '/senderDeliveryScreen';

  const SenderDeliveryDetails({Key? key}) : super(key: key);

  @override
  SenderDeliveryDetailsState createState() => SenderDeliveryDetailsState();
}

class SenderDeliveryDetailsState extends State<SenderDeliveryDetails> {
  bool onTapped = false;

  bool value = false;

  DetailsResult? pickUpLocationAddress;

  GooglePlace googlePlace = GooglePlace(GOOGLE_MAPS_API_KEY);
  late FocusNode pickUpFocusNode;
  Timer? _debounce;

  final _formKey = GlobalKey<FormState>();
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    pickUpFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // deliveryProvider.disposeSenderDetails();
    pickUpFocusNode.dispose();

    super.dispose();
  }

  autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);

    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
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
                  "Sender Details",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryGoldColor),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                CustomDeliveryTextField(
                  hint: "Sender Name",
                  controller: senderName,
                  icon: Icon(Icons.person),
                ),
                SizedBox(
                  height: getHeight(12, context),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: kTextGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Row(children: [
                        const Icon(Icons.house),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 18),
                            focusNode: pickUpFocusNode,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false)
                                _debounce!.cancel();
                              _debounce =
                                  Timer(const Duration(milliseconds: 1000), () {
                                if (value.isNotEmpty) {
                                  //places api
                                  autoCompleteSearch(value);
                                } else {
                                  //clear out the results
                                  setState(() {
                                    predictions = [];
                                    pickUpLocationAddress = null;
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 5, right: 5),
                                border: InputBorder.none,
                                fillColor: kTextGrey,
                                focusColor: kTextGrey,
                                hintText: "Pick Up Location",
                                suffixIcon: pickUpLocation.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            predictions = [];
                                            pickUpLocation.clear();
                                          });
                                        },
                                        icon: Icon(Icons.clear_outlined))
                                    : null),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.pin_drop),
                        title: Text(predictions[index].description.toString()),
                        onTap: () async {
                          final placeId = predictions[index].placeId!;
                          final details =
                              await googlePlace.details.get(placeId);

                          if (details != null &&
                              details.result != null &&
                              mounted) {
                            if (pickUpFocusNode.hasFocus) {
                              setState(() {});
                            }
                          }
                        },
                      );
                    }),
                SizedBox(
                  height: getHeight(12, context),
                ),
                CustomDeliveryTextField(
                  hint: "Nearest Landmark",
                  icon: Icon(Icons.location_on),
                  controller: pickUpLandMark,
                ),
                SizedBox(
                  height: getHeight(12, context),
                ),
                CustomDeliveryTextField(
                  hint: "Mobile Number",
                  icon: Icon(Icons.phone),
                  controller: senderPhone,
                ),
                SizedBox(
                  height: getHeight(15, context),
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
                    SizedBox(width: getWidth(5, context)),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getHeight(12, context),
                ),
                CustomDeliveryTextField(
                    hint: "Item Description",
                    controller: description,
                    icon: Icon(Icons.gif_box_rounded)),
                SizedBox(
                  height: getHeight(12, context),
                ),
                CustomDeliveryTextField(
                    hint: "Special Instruction",
                    controller: instruction,
                    icon: Icon(Icons.question_mark)),
                SizedBox(
                  height: getHeight(15, context),
                ),
                const BuildCheckBox(),
                SizedBox(
                  height: getHeight(15, context),
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
                    SizedBox(width: getWidth(5, context)),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.width / 20),
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
  bool isFragile = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Please tick if this parcel is considered as fragile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            // fontWeight: FontWeight.w400,
          ),
        ),
        Checkbox(
            value: isFragile,
            activeColor: kPrimaryGoldColor,
            onChanged: (isFragile) => setState(() {
                  this.isFragile = isFragile!;
                })),
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
          text: "Instant \n Delivery",
          fontSize: getFont(16, context),
          height: getHeight(60, context),
          width: MediaQuery.of(context).size.width / 2.5,
        ),
        //ToggleButtons(children: children, isSelected: isSelected),
        CustomButton(
          onPressed: () {},
          text: "Scheduled \n Delivery",
          fontSize: getFont(16, context),
          height: getHeight(60, context),
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
    return CustomButton(
        height: getHeight(70, context),
        fontSize: getHeight(20, context),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ReceiverDeliveryDetails()));
        },
        text: "Continue");
  }
}
