// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/screens/request_delivery/delivery_summary.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../../utility/helpers/controllers.dart';

class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  DetailsResult? pickupLocation;
  DetailsResult? dropoffLocation;

  late LatLng? pickUpLatLng;
  late LatLng? dropOffLatLng;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;
  bool _useCurrentLocationPickUp = false;
  bool _useCurrentLocationDropOff = false;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googlePlace = GooglePlace(GOOGLE_MAPS_API_KEY);
    getCurrentLocation();
    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  LatLng? currentLocation;

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    return;
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: pickUpLocation,
              autofocus: false,
              focusNode: startFocusNode,
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
                              predictions = [];
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
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                      pickupLocation = null;
                      pickUpLatLng = LatLng(
                          pickupLocation!.geometry!.location!.lat!,
                          pickupLocation!.geometry!.location!.lng!);
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
                        _useCurrentLocationPickUp = !_useCurrentLocationPickUp;
                      });
                    })
              ],
            ),
            SizedBox(height: 30),
            TextField(
              controller: dropOffLocation,
              autofocus: false,
              focusNode: endFocusNode,
              enabled: pickUpLocation.text.isNotEmpty && pickupLocation != null,
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
                              predictions = [];
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
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                      dropoffLocation = null;
                    });
                  }
                });
              },
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId!;
                      final details = await googlePlace.details.get(placeId);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        if (startFocusNode.hasFocus) {
                          setState(() {
                            pickupLocation = details.result;
                            pickUpLocation.text = details.result!.name!;
                            predictions = [];
                          });
                        } else {
                          setState(() {
                            dropoffLocation = details.result;
                            dropOffLocation.text = details.result!.name!;
                            predictions = [];
                            pickUpLatLng = LatLng(
                                pickupLocation!.geometry!.location!.lat!,
                                pickupLocation!.geometry!.location!.lng!);

                            dropOffLatLng = LatLng(
                                dropoffLocation!.geometry!.location!.lat!,
                                dropoffLocation!.geometry!.location!.lng!);
                          });
                        }

                        if (pickupLocation != null && dropoffLocation != null) {
                          print('navigate');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutDelivery(
                                  pickupLatLng: pickUpLatLng,
                                  dropoffLatLng: dropOffLatLng),
                            ),
                          );
                        } else if (_useCurrentLocationPickUp == true &&
                            dropoffLocation != null) {
                          print('navigate');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutDelivery(
                                  pickupLatLng: pickUpLatLng,
                                  dropoffLatLng: dropOffLatLng),
                            ),
                          );
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
          ],
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
