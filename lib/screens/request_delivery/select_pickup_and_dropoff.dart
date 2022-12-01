// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class SelectPickUpScreen extends StatefulWidget {
  @override
  _SelectPickUpScreenState createState() => _SelectPickUpScreenState();
}

class _SelectPickUpScreenState extends State<SelectPickUpScreen> {
  late GooglePlace googlePlace;

  final pickUpLocationController = TextEditingController();
  final dropoffLocationController = TextEditingController();

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;
  bool _useCurrentLocationPickUp = false;
  bool _useCurrentLocationDropOff = false;

  Timer? _debounce;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;
  List<AutocompletePrediction> predictions = [];

  final Mode _mode = Mode.overlay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  getCurrentLocation() async {
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
              controller: pickUpLocationController,
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
                  suffixIcon: pickUpLocationController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              pickUpLocationController.clear();
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
                  } else {
                    //clear out the results
                    setState(() {});
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
              controller: dropoffLocationController,
              autofocus: false,
              focusNode: endFocusNode,
              enabled: pickUpLocationController.text.isNotEmpty,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'DropOff Location',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: dropoffLocationController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              dropoffLocationController.clear();
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
                  } else {
                    //clear out the results
                    setState(() {});
                  }
                });
              },
            ),
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
