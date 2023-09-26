// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/controllers.dart';

class SelectLocationScreen extends StatelessWidget {
  final String deliveryType;
  SelectLocationScreen({super.key, required this.deliveryType});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: pickUpLocationController,
                autofocus: false,
                focusNode: locationProvider.startFocusNode,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    hintText: 'Pickup Location',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 24),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    suffixIcon: pickUpLocationController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              locationProvider.clearPickUpLocationPredictions();
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (pickupValue) {
                  if (locationProvider.debounce?.isActive ?? false) {
                    locationProvider.debounce!.cancel();
                  }
                  locationProvider.debounce =
                      Timer(const Duration(milliseconds: 1000), () {
                    if (pickupValue.isNotEmpty) {
                      //places api
                      locationProvider.autoCompleteSearch(pickupValue);
                    } else {
                      //clear out the results
                      locationProvider.setPickUpPredictions();
                    }
                  });
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tick to use current location",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                  Checkbox(
                      value: locationProvider.useCurrentLocationPickUp,
                      activeColor: kPrimaryGoldColor,
                      onChanged: (bool? value) async {
                        locationProvider.useCheckBoxForCurrentPickUp();
                      })
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: dropOffLocationController,
                autofocus: false,
                focusNode: locationProvider.endFocusNode,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    hintText: 'DropOff Location',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 24),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    suffixIcon: dropOffLocationController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              locationProvider
                                  .clearDropOffLocationPredictions();
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (locationProvider.debounce?.isActive ?? false) {
                    locationProvider.debounce!.cancel();
                  }
                  locationProvider.debounce =
                      Timer(const Duration(milliseconds: 1000), () {
                    if (value.isNotEmpty) {
                      //places api
                      locationProvider.autoCompleteSearch(value);
                    } else {
                      //clear out the results
                      locationProvider.predictions = [];
                      locationProvider.dropoffLocation = null;
                    }
                  });
                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: locationProvider.predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        locationProvider.predictions[index].description
                            .toString(),
                      ),
                      onTap: () async {
                        final placeId =
                            locationProvider.predictions[index].placeId!;
                        final details = await locationProvider
                            .googlePlace.details
                            .get(placeId);

                        if (details != null && details.result != null) {
                          if (locationProvider.startFocusNode.hasFocus) {
                            locationProvider.setPickUpLocation(index);
                          } else if (locationProvider.endFocusNode.hasFocus) {
                            locationProvider.setDropOffLocation(index);
                          }

                          if (locationProvider.pickupLocation != null &&
                              locationProvider.dropoffLocation != null) {
                          } else if (locationProvider
                                      .useCurrentLocationPickUp ==
                                  true &&
                              locationProvider.dropoffLocation != null) {}
                        }
                      },
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tick to use current location",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                  Checkbox(
                      value: locationProvider.useCurrentLocationDropOff,
                      activeColor: kPrimaryGoldColor,
                      onChanged: (bool? value) async {
                        await locationProvider.useCheckBoxForCurrentDropOff();
                      })
                ],
              ),
              SizedBox(
                height: getHeight(30, context),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.white,
                      elevation: 20),
                  onPressed: () async {
                    if (deliveryType == "DELIVERY") {
                      await locationProvider.createDeliveryRequest(context);
                      var response =
                          await locationProvider.processDelivery(context);
                      if (response == true) {
                        ////print('navigate');
                        locationProvider.changeWidgetShowed(
                            showWidget: Show.CHECKOUT_DELIVERY);

                        changeScreenReplacement(context, MapWidget());
                      } else {
                        return;
                      }
                    } else if (deliveryType == "RIDE") {
                      await locationProvider
                          .createInterstateRideRequest(context);
                      await locationProvider.processDelivery(context);
                      var response =
                          await locationProvider.processDelivery(context);
                      if (response == true) {
                        locationProvider.changeWidgetShowed(
                            showWidget: Show.CHECKOUT_INTERCITY_RIDE);

                        changeScreenReplacement(context, MapWidget());
                      }
                    } else {
                      return;
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
