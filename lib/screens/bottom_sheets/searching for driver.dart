import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/home/home_screen.dart';
import 'package:gold_line/screens/my_deliveries/select_type.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

import '../../utility/helpers/constants.dart';

class SearchingForDriver extends StatefulWidget {
  const SearchingForDriver({Key? key}) : super(key: key);

  @override
  State<SearchingForDriver> createState() => _SearchingForDriverState();
}

class _SearchingForDriverState extends State<SearchingForDriver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 30.appWidth(context),
              vertical: 10.appHeight(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.appHeight(context),
              ),
              Center(
                child: SizedBox(
                  height: 280.appHeight(context),
                  child: SvgPicture.asset("assets/booksucess.svg"),
                ),
              ),
              const Center(
                child: AutoSizeText(
                  "Booking Created Successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryGoldColor,
                  ),
                ),
              ),
              SizedBox(
                height: 40.appHeight(context),
              ),
              const Center(
                child: Text(
                  "A Rider/Driver will Pickup within the Hour.\nYou will be notified when the rider/driver is assigned to pickup.\nCheck my Deliveries Page for  delivery Status and details of the rider/driver. or Call  08138969994 for Support.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 60.appHeight(context),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    changeScreenReplacement(
                        context, const MyDeliveriesOptionScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70, shape: const StadiumBorder()),
                  child: const Text(
                    "Go To My Bookings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 20.appHeight(context),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    removeScreenUntil(context, const HomeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryGoldColor,
                      shape: const StadiumBorder()),
                  child: const Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const AutoSizeText(
                  textAlign: TextAlign.center,
                  'Note that Cancellation Prices may apply depending on the circumstances.'),
              const AutoSizeText(
                  textAlign: TextAlign.center,
                  'Check for delivery status updates on "My Deliveries" option.')
            ],
          ),
        ),
      ),
    );
  }
}
