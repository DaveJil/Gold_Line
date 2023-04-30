import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/request_delivery/select_location.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:provider/provider.dart';

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

  void saveData() async {}

  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider = Provider.of<MapProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: kPrimaryGoldColor,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Delivery Details",
          style: TextStyle(
              color: kVistaWhite, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
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
                      fontSize: 16,
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
                  controller: description,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDeliveryTextField(
                  hint: "Special Instruction",
                  icon: const Icon(Icons.question_mark),
                  controller: instruction,
                ),
                const SizedBox(
                  height: 12,
                ),
                const BuildCheckBox(),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Row(
                  children: [
                    Text(
                      "Size Of Item:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getHeight(20, context),
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
                  height: getHeight(20, context),
                ),
                const BuildItemSize(),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Row(
                  children: [
                    Text(
                      "Delivery Options:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getHeight(20, context),
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
                SizedBox(
                  height: getHeight(20, context),
                ),
                Row(
                  children: [
                    Expanded(child: DeliveryOption()),
                    SizedBox(
                      width: getWidth(20, context),
                    ),
                    Expanded(child: SelectCity())
                  ],
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Row(
                  children: [
                    Text(
                      "Payment Options:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getHeight(20, context),
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
                  height: getHeight(14, context),
                ),
                PayerRadioButton(),
                SizedBox(height: size.width / 15),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.appWidth(context)),
                  child: CustomButton(
                      onPressed: () {
                        changeScreen(context, SelectLocationScreen());
                      },
                      text: "Set Delivery Location"),
                )
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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AutoSizeText(
                "Please tick if you require express(instant) delivery\nNote: Additional charges would be applied",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  // fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        Checkbox(
            value: provider.isExpress,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                provider.isExpress = value!;
              });
              // provider.isExpress = value!;
              print(provider.isExpress);
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
  List size = [  "none", "small", "medium", "large"
  ];

  // String? provider.sizeColor;

  @override
  Widget build(BuildContext context) {

    // final provider = Provider.of<MapProvider>(context);
    final provider = context.watch<MapProvider>();
    return SizedBox(
      // height: height(context)/10,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  provider.sizeColor = "small";
                  print(provider.sizeColor);

                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.sizeColor == "small"
                      ? kPrimaryGoldColor
                      :kVistaWhite,
                  // provider.packageSize == PackageSize.medium? MaterialStateProperty.all<Color>(Colors.blue):kVistaWhite,
                  elevation: 10),
              child: SizedBox(
                height: getHeight(70, context),
                width: getWidth(60, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 15,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      "Small",
                      maxLines: 1,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.appWidth(context),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  provider.sizeColor = "medium";
                  print(provider.sizeColor);

                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.sizeColor == "medium"
                      ? kPrimaryGoldColor
                      :kVistaWhite,
                  // provider.packageSize == PackageSize.medium? MaterialStateProperty.all<Color>(Colors.blue):kVistaWhite,
                  elevation: 10),
              child: SizedBox(
                height: getHeight(70, context),
                width: getWidth(80, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 15,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      "Medium",
                      maxLines: 1,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.appWidth(context),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  provider.sizeColor = "large";
                  print(provider.sizeColor);

                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.sizeColor == "large"
                      ? kPrimaryGoldColor
                      :kVistaWhite,
                  elevation: 10),
              child: SizedBox(
                height: getHeight(70, context),
                width: getWidth(70, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.boxOpen,
                      size: 15,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      "Large",
                      maxLines: 1,
                      style: TextStyle(fontSize: 6, color: Colors.black),
                    ),
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

  // String? select;
  // int btnValue;
  // String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 10.appWidth(context),
        ),
        Expanded(child: buildPayerOption(0, "Sender Pays")),
        SizedBox(
          width: 10.appWidth(context),
        ),
        Expanded(child: buildPayerOption(1, "Receiver Pays"))
      ],
    );
  }

  Widget buildPayerOption(int btnValue, String title) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: mapProvider.whoFuckingPays == payer[btnValue]
                  ? kPrimaryGoldColor
                  : Colors.white,
              border: Border.all(
                color: kPrimaryGoldColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) =>
                mapProvider.whoFuckingPays == payer[btnValue]
                    ? kPrimaryGoldColor
                    : Colors.white),
            activeColor: Theme.of(context).primaryColor,
            value: payer[btnValue],
            groupValue: mapProvider.whoFuckingPays,
            onChanged: (value) async {
              mapProvider.whoFuckingPays = value;

              setState(() {
                print(value);
                mapProvider.whoFuckingPays = value;
              });
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: AutoSizeText(title,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              )),
        )
      ],
    );
  }
}

class DeliveryOption extends StatefulWidget {
  const DeliveryOption({Key? key}) : super(key: key);

  @override
  State<DeliveryOption> createState() => _DeliveryOptionState();
}

class _DeliveryOptionState extends State<DeliveryOption> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    // Initial Selected Value

    // List of items in our dropdown menu
    var items = [
      'Select Delivery Type',
      'Dispatch Bike',
      'Interstate Courier',
    ];

    return DropdownButton<String>(
      // Initial Value
      value: provider.deliveryDropDownValue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        provider.deliveryDropDownValue = newValue!;

        setState(() {
          provider.deliveryDropDownValue = newValue;
        });
      },
    );
  }
}

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    // Initial Selected Value

    // List of items in our dropdown menu
    var items = [
      'Select City',
      'Lagos',
      'Federal Capital Territory',
      'Rivers',
    ];

    return DropdownButton<String>(
      // Initial Value
      value: provider.cityDropDownValue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        provider.cityDropDownValue = newValue!;

        setState(() {
          provider.cityDropDownValue = newValue;
        });
      },
    );
  }
}
