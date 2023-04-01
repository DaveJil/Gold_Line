// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/controllers.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  SelectLocationScreenState createState() => SelectLocationScreenState();
}

class SelectLocationScreenState extends State<SelectLocationScreen> {
  Timer? _debounce;
  bool _useCurrentLocationPickUp = false;
  bool _useCurrentLocationDropOff = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider = Provider.of<MapProvider>(context);
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
                focusNode: mapProvider.startFocusNode,
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
                              setState(() {
                                mapProvider.predictions = [];
                                pickUpLocationController.clear();
                                _useCurrentLocationPickUp = false;
                              });
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (pickupValue) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    if (pickupValue.isNotEmpty) {
                      //places api
                      mapProvider.autoCompleteSearch(pickupValue);
                    } else {
                      //clear out the results
                      setState(() {
                        mapProvider.predictions = [];
                        mapProvider.pickupLocation = null;
                        mapProvider.pickUpLatLng = LatLng(
                            mapProvider
                                .pickupLocation!.geometry!.location!.lat!,
                            mapProvider
                                .pickupLocation!.geometry!.location!.lng!);
                      });
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
                      value: _useCurrentLocationPickUp,
                      activeColor: kPrimaryGoldColor,
                      onChanged: (bool? value) async {
                        mapProvider.pickUpState =
                            await mapProvider.getStateFromCoordinates(
                                point: mapProvider.center!);

                        setState(() {
                          mapProvider.predictions = [];
                          pickUpLocationController.text =
                              mapProvider.userAddressText!;
                          mapProvider.pickUpLatLng = LatLng(
                              mapProvider.center!.latitude,
                              mapProvider.center!.longitude);
                          _useCurrentLocationPickUp =
                              !_useCurrentLocationPickUp;
                        });
                      })
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: dropOffLocationController,
                autofocus: false,
                focusNode: mapProvider.endFocusNode,
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
                              setState(() {
                                mapProvider.predictions = [];
                                _useCurrentLocationDropOff = false;
                                dropOffLocationController.clear();
                              });
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    if (value.isNotEmpty) {
                      //places api
                      mapProvider.autoCompleteSearch(value);
                    } else {
                      //clear out the results
                      mapProvider.predictions = [];
                      mapProvider.dropoffLocation = null;
                    }
                  });
                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: mapProvider.predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        mapProvider.predictions[index].description.toString(),
                      ),
                      onTap: () async {
                        final placeId = mapProvider.predictions[index].placeId!;
                        final details =
                            await mapProvider.googlePlace.details.get(placeId);
                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          if (mapProvider.startFocusNode.hasFocus) {
                            String pickUpAddress =
                                await mapProvider.getAddressFromCoordinates(
                                    point: mapProvider.pickUpLatLng!);
                            mapProvider.pickupLocation = details.result;
                            mapProvider.pickUpLatLng = LatLng(
                                mapProvider
                                    .pickupLocation!.geometry!.location!.lat!,
                                mapProvider
                                    .pickupLocation!.geometry!.location!.lng!);
                            pickUpLocationController.text =
                                details.result!.formattedAddress!;
                            mapProvider.pickUpState =
                                await mapProvider.getStateFromCoordinates(
                                    point: mapProvider.pickUpLatLng!);
                            print(mapProvider.pickUpState);

                            setState(() {
                              pickUpLocationController.text =
                                  details.result!.formattedAddress!;
                              mapProvider.predictions = [];
                            });
                          } else if (mapProvider.endFocusNode.hasFocus) {
                            mapProvider.dropoffLocation = details.result;
                            mapProvider.dropOffLatLng = LatLng(
                                mapProvider
                                    .dropoffLocation!.geometry!.location!.lat!,
                                mapProvider
                                    .dropoffLocation!.geometry!.location!.lng!);
                            String dropOffAddress =
                                await mapProvider.getAddressFromCoordinates(
                                    point: mapProvider.dropOffLatLng!);
                            print(dropOffAddress);
                            dropOffLocationController.text =
                                details.result!.formattedAddress!;
                            mapProvider.dropOffState =
                                await mapProvider.getStateFromCoordinates(
                                    point: mapProvider.dropOffLatLng!);
                            print(mapProvider.dropOffState);

                            setState(() {
                              dropOffLocationController.text =
                                  details.result!.formattedAddress!;
                              mapProvider.predictions = [];
                              print(dropOffLocationController.text);
                            });
                          }

                          if (mapProvider.pickupLocation != null &&
                              mapProvider.dropoffLocation != null) {
                          } else if (_useCurrentLocationPickUp == true &&
                              mapProvider.dropoffLocation != null) {
                            print('navigate');
                          }
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
                      value: _useCurrentLocationDropOff,
                      activeColor: kPrimaryGoldColor,
                      onChanged: (bool? value) async {
                        mapProvider.dropOffLatLng = LatLng(
                            mapProvider.center!.latitude,
                            mapProvider.center!.longitude);
                        mapProvider.dropOffState =
                            await mapProvider.getStateFromCoordinates(
                                point: mapProvider.center!);
                        setState(() {
                          mapProvider.predictions = [];
                          dropOffLocationController.text =
                              mapProvider.userAddressText!;
                          mapProvider.dropOffLatLng = LatLng(
                              mapProvider.center!.latitude,
                              mapProvider.center!.longitude);
                          _useCurrentLocationDropOff =
                              !_useCurrentLocationDropOff;
                        });
                      })
                ],
              ),
              SizedBox(
                height: getHeight(30, context),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: TextButton(
                    onPressed: () async {
                      await mapProvider.createDeliveryRequest(context);
                      await mapProvider.processDelivery();
                      print('navigate');
                      mapProvider.changeWidgetShowed(
                          showWidget: Show.CHECKOUT_DELIVERY);

                      changeScreenReplacement(context, MapWidget());
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PickUpCheckBox extends StatefulWidget {
  const PickUpCheckBox({Key? key}) : super(key: key);

  @override
  State<PickUpCheckBox> createState() => _PickUpCheckBoxState();
}

class _PickUpCheckBoxState extends State<PickUpCheckBox> {
  bool _useCurrentLocation = false;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            value: _useCurrentLocation,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                _useCurrentLocation = !_useCurrentLocation;
              });
            })
      ],
    );
  }
}

class DropOffCheckBox extends StatefulWidget {
  const DropOffCheckBox({Key? key}) : super(key: key);

  @override
  State<DropOffCheckBox> createState() => _DropOffCheckBoxState();
}

class _DropOffCheckBoxState extends State<DropOffCheckBox> {
  bool _useCurrentLocation = false;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            value: _useCurrentLocation,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                _useCurrentLocation = !_useCurrentLocation;
              });
            })
      ],
    );
  }
}
