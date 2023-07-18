import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/custom_button.dart';
import '../../utility/helpers/delivery_input.dart';
import '../../utility/providers/map_provider.dart';

class InterCityRideDetails extends StatefulWidget {
  const InterCityRideDetails({Key? key}) : super(key: key);

  @override
  State<InterCityRideDetails> createState() => _InterCityRideDetailsState();
}

class _InterCityRideDetailsState extends State<InterCityRideDetails> {

  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: kPrimaryGoldColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Booking Details",
          style: TextStyle(
              color: kPrimaryGoldColor, fontSize: 16, fontWeight: FontWeight.w500),
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
              "Specify Inter City Ride Details",
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
              hint: "Name",
              icon: const Icon(Icons.person),
              controller: interCityBookingName,
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDeliveryTextField(
              hint: "Phone Number",
              icon: const Icon(Icons.phone),
              controller: interCityBookingPhone,
            ),
            const SizedBox(
              height: 12,
            ),


            CustomDeliveryTextField(

              hint: "How many seats are you booking?",
              icon: const Icon(FontAwesomeIcons.chair),
              controller: interCityBookingNumberOfSeats,
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: () {}, child: Text(
              mapProvider.selectedBookingDate.toString()
            )),

            const SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: () {}, child: Text(
                mapProvider.selectedBookingTime.toString()
            )),
            SizedBox(
              height: 20.appHeight(context),
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 50.appWidth(context)),
              child: CustomButton(
                  onPressed: () async{
                    // await mapProvider.createVanDeliveryRequest(context);
                    // changeScreenReplacement(context, MyVansDeliveriesScreen());
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


