import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/my_deliveries/vans_and_trucks/my_deliveries.dart';
import 'package:gold_line/screens/request_delivery/select_location.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/delivery_input.dart';
import '../map/map_widget.dart';

enum ProductSize { small, medium, large, multiple }

class VanDeliveryDetails extends StatefulWidget {
  static const String iD = '/senderDeliveryScreen';

  const VanDeliveryDetails({Key? key}) : super(key: key);

  @override
  VanDeliveryDetailsState createState() => VanDeliveryDetailsState();
}

class VanDeliveryDetailsState extends State<VanDeliveryDetails> {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Specify Delivery Details For Vans And Trucks",
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
              controller: vanSenderName,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDeliveryTextField(
              hint: "Pick Up Address",
              icon: const Icon(Icons.house),
              controller: vanPickUpLocationController,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDeliveryTextField(
              hint: "Sender Phone Number",
              icon: const Icon(Icons.phone),
              controller: vanSenderPhone,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDeliveryTextField(
              hint: "Receiver Name",
              icon: const Icon(Icons.person),
              controller: vanReceiverName,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDeliveryTextField(
              hint: "Delivery Address",
              icon: const Icon(Icons.house),
              controller: vanDropOffLocationController,
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

              hint: "Enter Price",
              icon: const Icon(Icons.wallet),
              controller: vanPrice,
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
            SizedBox(
              height: getHeight(20, context),
            ),
            Center(child: SelectCity()),
            SizedBox(
              height: getHeight(20, context),
            ),
             Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 50.appWidth(context)),
              child: CustomButton(
                  onPressed: () async{
                    await mapProvider.createVanDeliveryRequest(context);
                    changeScreenReplacement(context, MyVansDeliveriesScreen());
                  },
                  text: "Request Van/Truck"),
            )
          ],
        ),
      ),
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
      'Abia',
      'Adamawa',
      'Akwa Ibom',
      'Anambra',
      'Bauchi',
      'Bayelsa',
      'Benue',
      "Borno",
      "Cross River",
      "Delta",
      "Ebonyi",
      "Edo",
      "Ekiti",
      "Enugu",
      "Federal Capital Territory",
      "Gombe",
      "Imo",
      "Jigawa",
      "Kaduna",
      "Kano",
      "Katsina",
      "Kebbi",
      "Kogi",
      "Kwara",
      "Lagos",
      "Nasarawa",
      "Niger",
      "Ogun",
      "Ondo",
      "Osun",
      "Oyo",
      "Plateau",
      "Rivers",
      "Sokoto",
      "Taraba",
      "Yobe",
      "Zamfara"


    ];

    return Container(

      height: MediaQuery.of(context).size.height /18,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          // color: const Color.fromARGB(255, 205, 226, 243),
          color: const Color.fromARGB(255, 117, 117, 117)
              .withOpacity(0.4),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: DropdownButton<String>(

        focusColor: kPrimaryGoldColor.withOpacity(0.6),
        dropdownColor: Colors.white70,
        isExpanded: true,

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
      ),
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
      'Vans',
      'Trucks',
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


