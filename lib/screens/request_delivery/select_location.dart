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
                controller: pickUpLocation,
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
                    suffixIcon: pickUpLocation.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                mapProvider.predictions = [];
                                pickUpLocation.clear();
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
                      onChanged: (bool? value) {
                        setState(() {
                          _useCurrentLocationPickUp =
                              !_useCurrentLocationPickUp;
                        });
                      })
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: dropOffLocation,
                autofocus: false,
                focusNode: mapProvider.endFocusNode,
                enabled: pickUpLocation.text.isNotEmpty &&
                    mapProvider.pickupLocation != null,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    hintText: 'DropOff Location',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 24),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    suffixIcon: dropOffLocation.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                mapProvider.predictions = [];
                                dropOffLocation.clear();
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
                            mapProvider.setPickCoordinates();

                            double lat =
                                details.result!.geometry!.location!.lat!;
                            double lng =
                                details.result!.geometry!.location!.lng!;
                            mapProvider.changeRequestedDestination(
                                reqDestination:
                                    details.result!.formattedAddress,
                                lat: lat,
                                lng: lng);
                            mapProvider.updateDestination(
                                destination: details.result!.adrAddress);
                            LatLng coordinates = LatLng(lat, lng);
                            mapProvider.setPickCoordinates(
                                coordinates: coordinates);
                            mapProvider.changePickupLocationAddress(
                                address: details.result!.name);
                            setState(() {
                              mapProvider.pickupLocation = details.result;
                              pickUpLocation.text = details.result!.name!;
                              mapProvider.predictions = [];
                            });
                          } else {
                            double lat =
                                details.result!.geometry!.location!.lat!;
                            double lng =
                                details.result!.geometry!.location!.lng!;
                            mapProvider.changeRequestedDestination(
                                reqDestination: details.result!.name,
                                lat: lat,
                                lng: lng);
                            mapProvider.updateDestination(
                                destination: details.result!.name);
                            LatLng coordinates = LatLng(lat, lng);
                            mapProvider.setDestination(
                                coordinates: coordinates);
                            setState(() {
                              mapProvider.dropoffLocation = details.result;
                              dropOffLocation.text = details.result!.name!;
                              mapProvider.predictions = [];
                              mapProvider.pickUpLatLng = LatLng(
                                  mapProvider
                                      .pickupLocation!.geometry!.location!.lat!,
                                  mapProvider.pickupLocation!.geometry!
                                      .location!.lng!);

                              mapProvider.dropOffLatLng = LatLng(
                                  mapProvider.dropoffLocation!.geometry!
                                      .location!.lat!,
                                  mapProvider.dropoffLocation!.geometry!
                                      .location!.lng!);
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
                      onChanged: (bool? value) {
                        setState(() {
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
                height: getHeight(58, context),
                width: getWidth(200, context),
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
                    await mapProvider.createDeliveryRequest();
                    await mapProvider.createRoute();
                    await mapProvider.processDelivery();
                    print('navigate');
                    mapProvider.changeWidgetShowed(
                        showWidget: Show.CHECKOUT_DELIVERY);

                    changeScreenReplacement(context, MapWidget());
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                  ),
                ),
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
