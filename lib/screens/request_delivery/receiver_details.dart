import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/request_delivery/delivery_summary.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:google_place/google_place.dart';

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
  DetailsResult? dropOffLocationAddress;

  GooglePlace googlePlace = GooglePlace(GOOGLE_MAPS_API_KEY);
  late FocusNode dropOffFocusNode;
  Timer? _debounce;

  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    dropOffFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // deliveryProvider.disposeSenderDetails();
    dropOffFocusNode.dispose();

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
                CustomDeliveryTextField(
                  hint: "Receiver Name",
                  icon: const Icon(Icons.person),
                  controller: receiverName,
                ),
                const SizedBox(
                  height: 12,
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
                      child: Row(
                        children: [
                          const Icon(Icons.house),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 18),
                              focusNode: dropOffFocusNode,
                              cursorColor: Colors.black,
                              onChanged: (value) {
                                if (_debounce?.isActive ?? false)
                                  _debounce!.cancel();
                                _debounce = Timer(
                                    const Duration(milliseconds: 1000), () {
                                  if (value.isNotEmpty) {
                                    //places api
                                    autoCompleteSearch(value);
                                  } else {
                                    //clear out the results
                                    setState(() {
                                      predictions = [];
                                      dropOffLocationAddress = null;
                                    });
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 5, right: 5),
                                border: InputBorder.none,
                                fillColor: kTextGrey,
                                focusColor: kTextGrey,
                                hintText: "Pick Up Location",
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            if (dropOffFocusNode.hasFocus) {
                              setState(() {});
                            }
                          }
                        },
                      );
                    }),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Nearest Landmark",
                  icon: const Icon(Icons.location_on),
                  controller: dropOffLandMark,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Mobile Number",
                  icon: const Icon(Icons.phone),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CheckoutDelivery()));
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
