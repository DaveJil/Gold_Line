import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/screens/bottom_sheets/searching%20for%20driver.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart' as compon;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/delivery_model/delivery.dart';
import '../../models/driver_profile/driver_profile.dart';
import '../../models/route_model.dart';
import '../../models/user_profile/user_profile.dart';
import '../api.dart';
import '../helpers/constants.dart';
import '../helpers/custom_display_widget.dart';
import '../helpers/routing.dart';
import '../services/map_request.dart';

enum PackageSize { none, small, medium, large }

class MapProvider with ChangeNotifier {
  static const ACCEPTED = 'accepted';
  static const CANCELLED = 'cancelled';
  static const PENDING = 'pending';
  static const EXPIRED = 'expired';
  static const PICKUP_MARKER_ID = 'pickup';
  static const LOCATION_MARKER_ID = 'location';

  compon.DetailsResult? pickupLocation;
  compon.DetailsResult? dropoffLocation;

  String? pickUpLocationAddress;
  String? dropOffLocationAddress;

  LatLng? pickUpLatLng;
  LatLng? dropOffLatLng;

  FocusNode startFocusNode = FocusNode();
  FocusNode endFocusNode = FocusNode();

  compon.GooglePlace googlePlace = compon.GooglePlace(GOOGLE_MAPS_API_KEY);
  List<compon.AutocompletePrediction> predictions = [];

  Position? position;
  bool isLoading = false;
  LatLng? center;
  late LatLng? lastPosition = center;

  LatLng? pickupCoordinates;
  LatLng? destinationCoordinates;

  String? deliveryPrice = "0";

  String? countryCode;
  Set<Marker> _markers = {};
  Set<Polyline> _poly = {};

  Set<Polyline> get poly => _poly;
  Set<Polyline> _routeToDestinationPolys = {};
  Set<Polyline> _routeToDriverpoly = {};

  Set<Marker> get markers => _markers;

  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  BitmapDescriptor? locationPin;
  BitmapDescriptor? driverPin;
  UserProfile? user;

  String? selectSize;
  String? sizeColor;

  PackageSize packageSize = PackageSize.none;
  double? distanceStartLongitude;
  double? distanceEndLongitude;
  double? distanceStartLatitude;
  double? distanceEndLatitude;
  double? distanceBetweenPickAndDropOff;
  DriverProfile? driverProfile;
  RouteModel? routeModel;
  Color packageColor = Colors.white;

  final Completer<GoogleMapController> _controller = Completer();
  int timeCounter = 0;
  double percentage = 0;
  Timer? periodicTimer;
  List<LatLng> polylineCoordinates = [];

  bool isButtonDisabled = false;

  String? requestedDestination;
  int? deliveryId;
  String? userAddressText;
  String? whoFuckingPays;
  String? interCityBookingType;
  String? interCityVehicleType;

  String deliveryType = "";
  String? pickUpState;
  String? dropOffState;
  String? pickUpCountry;
  String? dropOffCountry;

  Timer? debounce;
  bool useCurrentLocationPickUp = false;
  bool useCurrentLocationDropOff = false;

  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

  String? requestStatus = "";
  double? requestedDestinationLat;

  double? requestedDestinationLng;
  DeliveryModel? rideRequestModel;
  BuildContext? mainContext;
  String? driverName;
  String? driverPhone;
  String? driverPlate;

  String? setTime, setDate;

  String? hour, minute, time;

  String? dateTime;

  String selectedBookingDate = "Select Departure Date";
  String selectedBookingTime = "Select Departure Time";

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String deliveryDropDownValue = 'Select Delivery Option';
  String vansDropDownValue = 'Select Delivery Type';

  String cityDropDownValue = 'Select City';
  String vehicleDropDownValue = "Select Vehicle Type";
  String routeDropDownValue = "Select Route";
  String departureTimeDownDownValue = "Select Departure Time";
  bool isExpress = false;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  MapProvider() {
    _setCustomMapPin();
    _getUserLocation();
    // _listenToDrivers();
    Geolocator.getPositionStream().listen(_updatePosition);
  }

  _updatePosition(Position newPosition) {
    position = newPosition;
    notifyListeners();
  }

  Future<LatLng?> _getUserLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    center = LatLng(position.latitude, position.longitude);
    print(center);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemark);
    Placemark place = placemark[0];
    print(place);
    //print(place);
    userAddressText =
        ' ${place.street}, ${place.subLocality}, ${place.locality}';

    if (prefs.getString(COUNTRY) == null) {
      String country = placemark[0].isoCountryCode!.toLowerCase();
      await prefs.setString(COUNTRY, "ng");
    }
    _addLocationMarker(center!, "100km");
    //////print("marker = $markers");

    notifyListeners();

    return center;
  }

  Future<String> getAddressFromCoordinates({required LatLng point}) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(point.latitude, point.longitude);

    String address =
        " ${addresses.first.street}, ${addresses.first.administrativeArea},";
    return address;
  }

  Future<String> getStateFromCoordinates({required LatLng point}) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(point.latitude, point.longitude);

    String state = "${addresses.first.administrativeArea},";
    return state;
  }

  Future<String> getCountryFromCoordinates({required LatLng point}) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(point.latitude, point.longitude);

    String country = "${addresses.first.country},";
    return country;
  }

  onCreate(mapController) {
    _controller.complete(mapController);
    notifyListeners();
  }

  setLastPosition(LatLng position) {
    lastPosition = position;
    notifyListeners();
  }

  onCameraMove(CameraPosition position) {
    //  MOVE the pickup marker only when selecting the pickup location
    lastPosition = position.target;
    // changePickupLocationAddress(address: "loading...");
    if (_markers.isNotEmpty) {
      _markers.forEach((element) async {
        if (element.markerId.value == PICKUP_MARKER_ID) {
          _markers.remove(element);
          pickupCoordinates = position.target;
          addPickupMarker(position.target);
          List<Placemark> placemark = await placemarkFromCoordinates(
              position.target.latitude, position.target.longitude);
          pickUpLocationController.text = placemark[0].name!;
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }

  _setCustomMapPin() async {
    driverPin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/markers/bike.png');

    locationPin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/markers/user.png');
  }

  Future sendRequest({LatLng? origin, LatLng? destination}) async {
    LatLng _org;
    LatLng _dest;

    if (origin == null && destination == null) {
      _org = pickUpLatLng!;
      _dest = dropOffLatLng!;
    } else {
      _org = origin!;
      _dest = destination!;
    }

    RouteModel route =
        await _googleMapsServices.getRouteByCoordinates(_org, _dest);
    routeModel = route;

    if (origin == null) {
      deliveryPrice = ((routeModel!.distance.value! / 500).toStringAsFixed(2));
    }
    List<Marker> mks = _markers
        .where((element) => element.markerId.value == "location")
        .toList();
    if (mks.isNotEmpty) {
      _markers.remove(mks[0]);
    }
// ! another method will be created just to draw the polys and add markers
    _addLocationMarker(destinationCoordinates!, routeModel!.distance.text!);
    center = destinationCoordinates;
    // _createRoute(route.points, color: Colors.deepOrange);
    // _createRoute(
    //   route.points,
    // );
    _routeToDestinationPolys = _poly;
    // createDeliveryRequest();
    notifyListeners();
  }

  void updateDestination({String? destination}) {
    dropOffLocationController.text = destination!;
    notifyListeners();
  }

  createRoute({Color? color}) async {
    clearPoly();
    var uuid = const Uuid();
    String polyId = uuid.v1();

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY, // Your Google Map Key
      PointLatLng(pickUpLatLng!.latitude, pickUpLatLng!.longitude),
      PointLatLng(dropOffLatLng!.latitude, dropOffLatLng!.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      notifyListeners();
    }
    notifyListeners();
    addPolyLine(polylineCoordinates);
    _poly = Set<Polyline>.of(polylines.values);

    notifyListeners();
  }

  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.green,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    notifyListeners();
  }

  clearPickUpLocationPredictions() {
    predictions = [];
    useCurrentLocationPickUp = false;
    pickUpLocationController.clear();
    notifyListeners();
  }

  clearDropOffLocationPredictions() {
    predictions = [];
    useCurrentLocationDropOff = false;
    dropOffLocationController.clear();
    notifyListeners();
  }

  setPickUpPredictions() {
    predictions = [];
    pickupLocation = null;
    pickUpLatLng = LatLng(pickupLocation!.geometry!.location!.lat!,
        pickupLocation!.geometry!.location!.lng!);
    notifyListeners();
  }

  useCheckBoxForCurrentPickUp() async {
    pickUpLatLng = LatLng(center!.latitude, center!.longitude);
    notifyListeners();
    pickUpState = await getStateFromCoordinates(point: center!);
    notifyListeners();

    pickUpCountry = await getCountryFromCoordinates(point: center!);
    notifyListeners();
    predictions = [];
    pickUpLocationController.text = userAddressText!;
    pickUpLatLng = LatLng(center!.latitude, center!.longitude);
    useCurrentLocationPickUp = !useCurrentLocationPickUp;
  }

  useCheckBoxForCurrentDropOff() async {
    dropOffLatLng = LatLng(center!.latitude, center!.longitude);
    notifyListeners();
    dropOffState = await getStateFromCoordinates(point: center!);
    notifyListeners();

    dropOffCountry = await getCountryFromCoordinates(point: center!);
    notifyListeners();
    predictions = [];
    dropOffLocationController.text = userAddressText!;
    notifyListeners();

    dropOffLatLng = LatLng(center!.latitude, center!.longitude);
    notifyListeners();

    useCurrentLocationDropOff = !useCurrentLocationDropOff;
    notifyListeners();
  }

  setPickUpLocation(int index) async {
    final placeId = predictions[index].placeId!;
    print(placeId);
    final details = await googlePlace.details.get(placeId);
    print(details);
    pickUpLocationController.text = predictions[index].description!;
    print(details);
    // pickUpLocationController.text = details!.result!.formattedAddress!;
    predictions = [];
    notifyListeners();
    pickupLocation = details!.result;
    print(pickupLocation);
    notifyListeners();
    pickUpLatLng = LatLng(pickupLocation!.geometry!.location!.lat!,
        pickupLocation!.geometry!.location!.lng!);
    notifyListeners();
    pickUpState = await getStateFromCoordinates(point: pickUpLatLng!);
    pickUpCountry = await getCountryFromCoordinates(point: pickUpLatLng!);
    notifyListeners();
  }

  setDropOffLocation(int index) async {
    final placeId = predictions[index].placeId!;
    final details = await googlePlace.details.get(placeId);
    print(details);
    dropOffLocationController.text = predictions[index].description!;

    // dropOffLocationController.text = details!.result!.formattedAddress!;
    predictions = [];
    notifyListeners();
    dropoffLocation = details!.result;

    dropOffLatLng = LatLng(dropoffLocation!.geometry!.location!.lat!,
        dropoffLocation!.geometry!.location!.lng!);
    dropOffState = await getStateFromCoordinates(point: dropOffLatLng!);
    dropOffCountry = await getCountryFromCoordinates(point: dropOffLatLng!);
    notifyListeners();
  }

  autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      //print(result.predictions!.first.description);
      predictions = result.predictions!;
      notifyListeners();
    }
    notifyListeners();
  }

// ANCHOR: MARKERS AND POLYS
  _addLocationMarker(LatLng position, String distance) {
    _markers.add(Marker(
        markerId: const MarkerId(LOCATION_MARKER_ID),
        position: position,
        anchor: const Offset(0, 0.85),
        infoWindow: InfoWindow(
            title: dropOffLocationController.text, snippet: distance),
        icon: locationPin!));
    notifyListeners();
  }

  addPickupMarker(LatLng position) {
    pickupCoordinates ??= position;
    _markers.add(Marker(
        markerId: const MarkerId(PICKUP_MARKER_ID),
        position: position,
        anchor: const Offset(0, 0.85),
        zIndex: 3,
        infoWindow: const InfoWindow(title: "Pickup", snippet: "location"),
        icon: locationPin!));
    notifyListeners();
  }

  clearMarkers() {
    _markers.clear();
    notifyListeners();
  }

  clearPoly() {
    _poly.clear();
    notifyListeners();
  }

  Future createDeliveryRequest(BuildContext context) async {
    //print(isExpress);
    await clearPoly();

    distanceBetweenPickAndDropOff = 0;
    polylineCoordinates = [];

    polylineCoordinates.add(pickUpLatLng!);
    polylineCoordinates.add(dropOffLatLng!);
    await calculateDistance();
    await createRoute();
    //print(distanceBetweenPickAndDropOff);
    Map<String, dynamic> values = {
      "receiver_name": receiverName.text,
      "receiver_phone": receiverPhone.text,
      "sender_name": senderName.text,
      "sender_phone": senderPhone.text,
      "pickup_longitude": pickUpLatLng!.longitude,
      "pickup_latitude": pickUpLatLng!.latitude,
      "dropoff_latitude": dropOffLatLng!.latitude,
      "dropoff_longitude": dropOffLatLng!.longitude,
      "status": 'pending',
      "city": pickUpState,
      "state": pickUpState,
      "package_size": sizeColor,
      "payment_by": whoFuckingPays.toString(),
      "distance": distanceBetweenPickAndDropOff,
      "pickup_address": pickUpLocationController.text,
      "dropoff_address": dropOffLocationController.text,
      "payment_method": "card",
      "description": description.text,
      "country": pickUpCountry,
      "dropoff_city": dropOffState,
      "dropoff_state": dropOffState,
      "dropoff_country": dropOffCountry
    };

    try {
      if (deliveryDropDownValue == "International") {
        values["country"] = pickUpCountry;
        values["dropoff_country"] = dropOffCountry;
        distanceBetweenPickAndDropOff = 0;
        values['distance'] = 0;

        print(pickUpCountry);
        print(dropOffCountry);
        print(dropOffState);
        final response =
            await CallApi().postData(values, 'user/international/delivery/new');
        print("international delivery");

        String code = response['code'];
        if (code == "success") {
          print("international delivery");

          distanceBetweenPickAndDropOff = 0;
          deliveryId = response['data']['id'];
          notifyListeners();
        } else {
          distanceBetweenPickAndDropOff = 0;
          String message = (response['message']).toString();

          CustomDisplayWidget.displayAwesomeSuccessSnackBar(
              context, message, "Check entered city, state");
        }
      } else {
        if (deliveryDropDownValue == "Interstate Courier") {
          values["state"] = pickUpState;
          values["city"] = pickUpState;
          values["dropoff_city"] = dropOffState;
          values["dropoff_state"] = dropOffState;
          final response =
              await CallApi().postData(values, 'user/interstate/delivery/new');
          print(response);
          print("interstatedelivery");

          String code = response['code'];
          if (code == "success") {
            distanceBetweenPickAndDropOff = 0;
            deliveryId = response['data']['id'];
            notifyListeners();
          } else {
            distanceBetweenPickAndDropOff = 0;
            String message = (response['message']).toString();

            CustomDisplayWidget.displayAwesomeSuccessSnackBar(
                context, message, "Check entered city, state");
          }
        } else {
          if (isExpress == true) {
            values['type'] = 'express';
            final response =
                await CallApi().postData(values, 'user/delivery/new');
            print("express");
            print(response);

            String code = response['code'];
            //print(code);
            if (code == "success") {
              distanceBetweenPickAndDropOff = 0;
              deliveryId = response['data']['id'];
              notifyListeners();
            } else {
              distanceBetweenPickAndDropOff = 0;
              String message = (response['message']).toString();

              CustomDisplayWidget.displayAwesomeSuccessSnackBar(
                  context, message, "Check entered city, state");
            }
          } else {
            final response =
                await CallApi().postData(values, 'user/delivery/new');
            print(response);

            String code = response['code'];
            if (code == "success") {
              distanceBetweenPickAndDropOff = 0;
              deliveryId = response['data']['id'];
              notifyListeners();
            } else {
              distanceBetweenPickAndDropOff = 0;
              String message = (response['message']).toString();

              CustomDisplayWidget.displayAwesomeSuccessSnackBar(
                  context, message, "Check entered city, state");
            }
          }
        }
        isExpress = false;
      }
      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
    notifyListeners();
  }

  Future createVanDeliveryRequest(BuildContext context) async {
    Map<String, dynamic> values = {
      "receiver_name": vanReceiverName.text,
      "receiver_phone": vanReceiverPhone.text,
      "sender_name": vanSenderName.text,
      "sender_phone": vanSenderPhone.text,
      "status": 'pending',
      "instruction": vanInstruction.text,
      "bid_price": vanPrice.text,
      "state": cityDropDownValue,
      "city": cityDropDownValue,
      "pickup_address": vanPickUpLocationController.text,
      "dropoff_address": vanDropOffLocationController.text,
      "payment_method": "card",
      "description": vanDescription.text,
    };

    try {
      final response =
          await CallApi().postData(values, 'user/cargo/delivery/new');
      String code = response['code'];
      if (code == "success") {
        print("success");
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, "Request For Van Submitted Successfully", "Success");
        deliveryId = response['data']['id'];
        notifyListeners();
      } else {
        distanceBetweenPickAndDropOff = 0;
        String message = (response['message']).toString();
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(
            context, message, "Check entered city, state");
      }
      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
    notifyListeners();
  }

  Future createInterstateRideRequest(BuildContext context) async {
    //print(isExpress);
    await clearPoly();
    print("inn");

    distanceBetweenPickAndDropOff = 0;
    polylineCoordinates = [];

    polylineCoordinates.add(pickUpLatLng!);
    polylineCoordinates.add(dropOffLatLng!);
    await calculateDistance();
    await createRoute();
    print(departureTimeDownDownValue);
    await getTime();
    String dateTimeString = "$selectedBookingDate $selectedBookingTime";
    print(dateTimeString);
    DateTime dateTimeObj =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString);
    print(dateTimeObj);
    print(vehicleDropDownValue);
    print(interCityBookingType);

    //print(distanceBetweenPickAndDropOff);
    Map<String, dynamic> values = {
      "type": "interstate_transport",
      "pickup_time": dateTimeString,
      "seats": interCityBookingNumberOfSeats.text,
      "transport_type": interCityBookingType!.toLowerCase(),
      "transport_vehicle_type": vehicleDropDownValue.toLowerCase(),
      "transport_route": interCityBookingTransportRoute.text,
      "status": 'pending',
      "city": pickUpState,
      "state": pickUpState,
      "package_size": sizeColor,
      "payment_by": "sender",
      "distance": distanceBetweenPickAndDropOff,
      "pickup_address": pickUpLocationController.text,
      "dropoff_address": dropOffLocationController.text,
      "country": pickUpCountry,
      "dropoff_city": dropOffState,
      "dropoff_state": dropOffState,
      "dropoff_country": dropOffCountry,
      "pickup_longitude": pickUpLatLng!.longitude,
      "pickup_latitude": pickUpLatLng!.latitude,
      "dropoff_latitude": dropOffLatLng!.latitude,
      "dropoff_longitude": dropOffLatLng!.longitude,
    };

    try {
      if (pickUpCountry != dropOffCountry) {
        CustomDisplayWidget.displayAwesomeSuccessSnackBar(context,
            "Booking Not Created Successfully", "Check entered city, state");
      } else {
        if (pickUpState != dropOffState) {
          values["state"] = pickUpState;
          values["city"] = pickUpState;
          values["dropoff_city"] = dropOffState;
          values["dropoff_state"] = dropOffState;
          final response = await CallApi()
              .postData(values, 'user/interstate-transport/delivery/new');
          print(response);

          String code = response['code'];
          if (code == "success") {
            distanceBetweenPickAndDropOff = 0;
            deliveryId = response['data']['id'];
            notifyListeners();
          } else {
            distanceBetweenPickAndDropOff = 0;
            String message = (response['message']).toString();
            print(message);
            CustomDisplayWidget.displayAwesomeSuccessSnackBar(
                context, message, "Check entered city, state");
          }
        } else {
          CustomDisplayWidget.displayAwesomeSuccessSnackBar(context,
              "Delivery not Created Sucessfully", "Check entered city, state");
        }
        isExpress = false;
      }
      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
    notifyListeners();
  }

  Future<bool> updatePaymentMethod(
    String paymentMethod,
    String paymentGateway,
    BuildContext context,
  ) async {
    Map<String, dynamic> values = {
      "gateway": paymentGateway,
      "payment_method": paymentMethod,
      "order_id": deliveryId,
      "payment_for": "delivery",
      "amount": deliveryPrice
    };
    isLoading = true;
    try {
      print(deliveryId);
      final response = await CallApi()
          .postData(values, 'user/delivery/create-payment/$deliveryId');

      if (response['code'] == "success") {
        isLoading = false;
        notifyListeners();
        return true;
      } else if (response['code'] == "insufficient-fund") {
        CustomDisplayWidget.displaySnackBar(
            context, "Insuffucient Funds. Deposit ");
        changeScreenReplacement(context, WalletScreen());
        return false;
      }
      return true;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future submitCardDelivery() async {
    Map<String, dynamic> values = {"payment_status": "paid"};
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final response =
          await CallApi().postData(values, 'user/delivery/submit/$deliveryId');
      print(response);
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future submitCashDelivery(BuildContext context) async {
    Map<String, dynamic> values = {"payment_method": "cash"};
    print(deliveryId);

    try {
      final response =
          await CallApi().postData(values, 'user/delivery/submit/$deliveryId');
      print(response);
      // String message = response["message"];
      //print(message);

      changeScreenReplacement(context, SearchingForDriver());
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      print(err.toString());
      throw Exception(err.toString());
    }
  }

  Future submitWalletDelivery(BuildContext context) async {
    try {
      Map<String, dynamic> values = {"payment_status": "paid"};

      final response =
          await CallApi().postData(values, 'user/delivery/submit/$deliveryId');
      print(response);

      changeScreenReplacement(context, SearchingForDriver());
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

// trip process endpoint

  Future<bool> processDelivery(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      final response =
          await CallApi().postData(null, "user/delivery/process/$deliveryId");
      final body = response;
      print(response);
      if (response['code'] == "success") {
        var val = response['data']['price'];
        //////print("val = $val");
        deliveryPrice = (((val + 50) ~/ 100) * 100).toInt().toString();
        preferences.setString('price', deliveryPrice!);
        return true;
      } else {
        String code = response['code'];

        String message = response['message'];
        CustomDisplayWidget.displayAwesomeFailureSnackBar(
            context, message, code);
      }

      return false;
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  setPickCoordinates({LatLng? coordinates}) {
    pickupCoordinates = coordinates;
    notifyListeners();
  }

  setDestination({LatLng? coordinates}) {
    destinationCoordinates = coordinates;
    notifyListeners();
  }

  changePickupLocationAddress({String? address}) {
    pickUpLocationController.text = address!;
    if (pickupCoordinates != null) {
      center = pickupCoordinates;
    }
    notifyListeners();
  }

  getRiderDetails() async {
    try {
      final response = await CallApi().getData('user/delivery/$deliveryId');

      final body = response;
      driverName = body['data']['profile']['first_name'];
      driverPhone = body['data']['profile']['phone'];
      driverPlate = body['data']['profile']['plate_number'];

      //print(driverName);
      //print(driverPhone);
      //print(driverPlate);

      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Timer checkStatusTimer = Timer.periodic(Duration(seconds: 10), (timer) {});

  void _updateLocationMarker(
      {required CameraPosition cameraPosition,
      required String markerId,
      required String markerTitle}) {
    try {
      Marker _marker =
          markers.singleWhere((element) => element.markerId.value == markerId);
      markers.remove(_marker);
      _addMarker(
          markerPosition: cameraPosition.target,
          id: markerId,
          title: markerTitle);
    } catch (error) {
      //print(error);
    }
  }

  _addMarker(
      {required LatLng markerPosition,
      required String id,
      required String title}) {
    markers.add(Marker(
        markerId: MarkerId(id),
        position: markerPosition,
        zIndex: 10,
        infoWindow: InfoWindow(title: title),
        icon: locationPin!));
    notifyListeners();
  }

  changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  changeMainContext(BuildContext context) {
    mainContext = context;
    notifyListeners();
  }

  changePackageSize({PackageSize? packageSize}) {
    packageSize = packageSize!;
    //print(packageSize);
    notifyListeners();
  }

  // Method for calculating the distance between two places
  Future<bool> calculateDistance() async {
    try {
      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.

      distanceStartLatitude = pickUpLatLng!.latitude;

      distanceStartLongitude = pickUpLatLng!.longitude;
      distanceEndLatitude = dropOffLatLng!.latitude;
      distanceEndLongitude = dropOffLatLng!.longitude;

      double totalDistance = 0.0;
      distanceBetweenPickAndDropOff = 0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      distanceBetweenPickAndDropOff = totalDistance;
      ////print('DISTANCE: $distanceBetweenPickAndDropOff km');
      notifyListeners();

      return true;
    } catch (e) {
      //print(e);
    }
    return false;
  }

// Formula for calculating distance between two coordinates
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      print(picked);
      selectedBookingDate =
          "${picked.year}-${(picked.month).toString().padLeft(2, '0')}-${(picked.day).toString().padLeft(2, '0')}";
      print(selectedBookingDate);
    }
  }

  getTime() async {
    print(departureTimeDownDownValue);
    if (departureTimeDownDownValue.contains("6am")) {
      selectedBookingTime = "06:00:00";
    } else if (departureTimeDownDownValue.contains("8am")) {
      selectedBookingTime = "08:00:00";
    } else if (departureTimeDownDownValue.contains("12pm")) {
      selectedBookingTime = "12:00:00";
    } else if (departureTimeDownDownValue.contains("6pm")) {
      selectedBookingTime = "18:00:00";
    }
    print(selectedBookingTime);
  }
}
