import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/request_delivery/select_location.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
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
        elevation: 0,
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
              color: kPrimaryGoldColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
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
            CustomDeliveryTextField(
              hint: "Phone Number",
              icon: const Icon(Icons.phone),
              controller: interCityBookingPhone,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDeliveryTextField(
              hint: "How many seats are you booking(eg 1,2, 3)?",
              icon: const Icon(FontAwesomeIcons.chair),
              controller: interCityBookingNumberOfSeats,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Luggage Size",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Divider()
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            BuildItemSize(),
            const SizedBox(
              height: 12,
            ),
            BookingTypeRadioButton(),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Select Vehicle Type:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: getHeight(20, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.appWidth(context)),
                Expanded(
                  child: SelectVehicle(),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Select Route:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: getHeight(20, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.appWidth(context)),
                Expanded(
                  child: SelectRoute(),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Select Departure Time:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: getHeight(20, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.appWidth(context)),
                Expanded(
                  child: SelectDepartureTime(),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  mapProvider.selectDate(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGoldColor),
                child: Text(mapProvider.selectedBookingDate.toString())),
            SizedBox(
              height: 20.appHeight(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.appWidth(context)),
              child: CustomButton(
                  onPressed: () async {
                    changeScreen(
                        context, SelectLocationScreen(deliveryType: "RIDE"));
                  },
                  text: "Select Location"),
            )
          ],
        ),
      ),
    );
  }
}

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({Key? key}) : super(key: key);

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    // Initial Selected Value

    // List of items in our dropdown menu
    var items = [
      "Classic(4 seater salon car)",
      "Business(8 seater mini bus)",
      "Executive(6 seater jeep)"
    ];

    return Container(
      height: MediaQuery.of(context).size.height / 18,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          // color: const Color.fromARGB(255, 205, 226, 243),
          color: const Color.fromARGB(255, 117, 117, 117).withOpacity(0.4),
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
        value: provider.vehicleDropDownValue,

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
          provider.vehicleDropDownValue = newValue!;

          setState(() {
            provider.vehicleDropDownValue = newValue;
          });
        },
      ),
    );
  }
}

class SelectDepartureTime extends StatefulWidget {
  const SelectDepartureTime({Key? key}) : super(key: key);

  @override
  State<SelectDepartureTime> createState() => _SelectDepartureTimeState();
}

class _SelectDepartureTimeState extends State<SelectDepartureTime> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    // Initial Selected Value

    // List of items in our dropdown menu
    var items = [
      'Select Departure time',
      "Early Morning 6am-7am",
      "Morning 8am-11am ",
      "Afternoon 12pm-5pm",
      "Night 6pm-12am"
    ];

    return Container(
      height: MediaQuery.of(context).size.height / 18,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          // color: const Color.fromARGB(255, 205, 226, 243),
          color: const Color.fromARGB(255, 117, 117, 117).withOpacity(0.4),
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
        value: provider.departureTimeDownDownValue,

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
          provider.departureTimeDownDownValue = newValue!;

          setState(() {
            provider.departureTimeDownDownValue = newValue;
          });
        },
      ),
    );
  }
}

class SelectRoute extends StatefulWidget {
  const SelectRoute({Key? key}) : super(key: key);

  @override
  State<SelectRoute> createState() => _SelectRouteState();
}

class _SelectRouteState extends State<SelectRoute> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    // Initial Selected Value

    // List of items in our dropdown menu
    var items = [
      'Lagos - Federal Capital Territory',
      'Lagos - Rivers',
      'Federal Capital Territory - Lagos',
      'Federal Capital Territory - Rivers',
      'Rivers - Lagos',
      'Rivers - Federal Capital Territory'
    ];

    return Container(
      height: MediaQuery.of(context).size.height / 18,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          // color: const Color.fromARGB(255, 205, 226, 243),
          color: const Color.fromARGB(255, 117, 117, 117).withOpacity(0.4),
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
        value: provider.routeDropDownValue,

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
          provider.routeDropDownValue = newValue!;

          setState(() {
            provider.routeDropDownValue = newValue;
          });
        },
      ),
    );
  }
}

class BuildItemSize extends StatefulWidget {
  const BuildItemSize({Key? key}) : super(key: key);

  @override
  State<BuildItemSize> createState() => _BuildItemSizeState();
}

class _BuildItemSizeState extends State<BuildItemSize> {
  List size = ["none", "small", "medium", "large"];

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
                  //print(provider.sizeColor);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.sizeColor == "small"
                      ? kPrimaryGoldColor
                      : kVistaWhite,
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
                  //print(provider.sizeColor);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.sizeColor == "medium"
                      ? kPrimaryGoldColor
                      : kVistaWhite,
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
                  //print(provider.sizeColor);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.sizeColor == "large"
                      ? kPrimaryGoldColor
                      : kVistaWhite,
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

class BookingTypeRadioButton extends StatefulWidget {
  const BookingTypeRadioButton({Key? key}) : super(key: key);

  @override
  State<BookingTypeRadioButton> createState() => _BookingTypeRadioButtonState();
}

class _BookingTypeRadioButtonState extends State<BookingTypeRadioButton> {
  List bookingType = [
    "Charter Booking",
    "Single Booking",
  ];

  String? select;
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
        Expanded(child: buildPayerOption(0, "Charter Booking")),
        SizedBox(
          width: 10.appWidth(context),
        ),
        Expanded(child: buildPayerOption(1, "Single Booking"))
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
              color: mapProvider.interCityBookingType == bookingType[btnValue]
                  ? kPrimaryGoldColor
                  : Colors.white,
              border: Border.all(
                color: kPrimaryGoldColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) =>
                mapProvider.interCityBookingType == bookingType[btnValue]
                    ? kPrimaryGoldColor
                    : Colors.white),
            activeColor: Theme.of(context).primaryColor,
            value: bookingType[btnValue],
            groupValue: mapProvider.interCityBookingType,
            onChanged: (value) async {
              setState(() {
                //print(value);
                mapProvider.interCityBookingType = value;
              });
              mapProvider.interCityBookingType = value;
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
