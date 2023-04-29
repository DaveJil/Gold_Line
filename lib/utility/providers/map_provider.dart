// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart' as compon;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/delivery_model/delivery.dart';
import '../../models/driver_profile/driver_profile.dart';
import '../../models/route_model.dart';
import '../../models/user_profile/user_profile.dart';
import '../api.dart';
import '../helpers/constants.dart';
import '../helpers/custom_button.dart';
import '../helpers/stars.dart';
import '../services/calls_and_sms.dart';
import '../services/delivery_services.dart';
import '../services/map_request.dart';

enum Show {
  HOME,
  CASH_PAYMENT,
  FLUTTERWAVE_PAYMENT,
  SEARCHING_FOR_DRIVER,
  DRIVER_FOUND,
  TRIP,
  CHECKOUT_DELIVERY,
  ORDER_STATUS
}

class MapProvider with ChangeNotifier {
  static const ACCEPTED = 'accepted';
  static const CANCELLED = 'cancelled';
  static const PENDING = 'pending';
  static const EXPIRED = 'expired';
  static const PICKUP_MARKER_ID = 'pickup';
  static const LOCATION_MARKER_ID = 'location';

  //general notification
  static const NAVIGATE_TO_DELIVERY_NOTIFICATION = 'delivery';
  static const NAVIGATE_TO_WALLET_NOTIFICATION = 'wallet';
  static const NAVIGATE_TO_NOTIFICATION = 'notifications';

  //delivery stages(status)
  static const DRIVER_ASSIGNED_NOTIFICATION = 'driver_assigned';
  // static const DELIVERY_PICKED_NOTIFICATION = 'delivery_picked'; //riders don't have app
  static const DELIVERY_CANCELED_NOTIFICATION = 'delivery_canceled';
  static const DELIVERY_ACCEPTED_NOTIFICATION = 'delivery_accepted';
  static const DELIVERY_REJECTED_NOTIFICATION = 'delivery_rejected';
  static const DELIVERY_COMPLETED_NOTIFICATION = 'delivery_completed';

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
  String? notificationType = "";
  late bool _isPickupSet = false;
  late bool _isDropOffSet = false;

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

  Show show = Show.HOME;

  DriverProfile? driverProfile;
  RouteModel? routeModel;

  final Completer<GoogleMapController> _controller = Completer();

  //  Driver request related variables
  bool lookingForDriver = false;
  bool alertsOnUi = false;
  bool driverFound = false;
  bool driverArrived = false;
  bool deliveryCompleted = false;
  DeliveryRequestServices _requestServices = DeliveryRequestServices();
  int timeCounter = 0;
  double percentage = 0;
  Timer? periodicTimer;
  List<LatLng> polylineCoordinates = [];

  String? requestedDestination;
  int? deliveryId;
  String? userAddressText;
  String? whoFuckingPays;

  //  this variable will listen to the status of the ride request
  StreamSubscription<AsyncSnapshot>? requestStream;
  // this variable will keep track of the drivers position before and during the ride
  StreamSubscription<AsyncSnapshot>? driverStream;
//  this stream is for all the driver on the app
  StreamSubscription<List<DriverProfile>>? allDriversStream;

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

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  MapProvider() {
    _setCustomMapPin();
    _getUserLocation();
    _listenToDrivers();
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

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    Placemark place = placemark[0];
    userAddressText =
        '${place.street}, ${place.subLocality}, ${place.locality}';

    if (prefs.getString(COUNTRY) == null) {
      String country = placemark[0].isoCountryCode!.toLowerCase();
      await prefs.setString(COUNTRY, "ng");
    }
    _addLocationMarker(center!, "100km");
    print("marker = $markers");

    notifyListeners();

    return center;
  }

  Future<String> getAddressFromCoordinates({required LatLng point}) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(point.latitude, point.longitude);

    String address =
        "${addresses.first.administrativeArea}, ${addresses.first.street}, ${addresses.first.locality}";
    return address;
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
    changePickupLocationAddress(address: "loading...");
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

  _animateCamera({required LatLng point}) async {
    await _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: point, tilt: 15, zoom: 19)));
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
    createDeliveryRequest();
    notifyListeners();
  }

  void updateDestination({String? destination}) {
    dropOffLocationController.text = destination!;
    notifyListeners();
  }

  createRoute({Color? color}) async {
    print(pickUpLatLng!);
    print(dropOffLatLng!);
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

  autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      print(result.predictions!.first.description);
      predictions = result.predictions!;
      notifyListeners();
    }
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

  void _addDriverMarker(
      {LatLng? position, double? rotation, String? driverId}) {
    var uuid = const Uuid();
    String markerId = uuid.v1();
    _markers.add(Marker(
        markerId: MarkerId(markerId),
        position: position!,
        rotation: rotation!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(1, 1),
        icon: driverPin!));
    notifyListeners();
  }

  _updateMarkers(List<DriverProfile> drivers) {
//    this code will ensure that when the driver markers are updated the location marker wont be deleted
    List<Marker> locationMarkers = _markers
        .where((element) => element.markerId.value == 'location')
        .toList();
    clearMarkers();
    if (locationMarkers.isNotEmpty) {
      _markers.add(locationMarkers[0]);
    }

//    here we are updating the drivers markers
    drivers.forEach((DriverProfile driver) {
      _addDriverMarker(
          driverId: driver.id,
          position:
              LatLng(driver.profile?.latitude!, driver.profile?.longitude));
      // rotation: driver.heading);
    });
    notifyListeners();
  }

  // _updateDriverMarker(Marker marker) {
  //   _markers.remove(marker);
  //   sendRequest(
  //       origin: pickupCoordinates, destination: driverProfile?.getPosition());
  //   notifyListeners();
  //   _addDriverMarker(
  //       position: driverProfile!.getPosition(),
  //       rotation: driverProfile!.heading,
  //       driverId: driverProfile!.id);
  // }

  clearMarkers() {
    _markers.clear();
    notifyListeners();
  }

  _clearDriverMarkers() {
    _markers.forEach((element) {
      String _markerId = element.markerId.value;
      if (_markerId != driverProfile?.id ||
          _markerId != LOCATION_MARKER_ID ||
          _markerId != PICKUP_MARKER_ID) {
        _markers.remove(element);
        notifyListeners();
      }
    });
  }

  clearPoly() {
    _poly.clear();
    notifyListeners();
  }

  navigateToHomeWidget() {
    changeWidgetShowed(showWidget: Show.HOME);
  }

  changeRequestedDestination(
      {String? reqDestination, double? lat, double? lng}) {
    requestedDestination = reqDestination;
    requestedDestinationLat = lat;
    requestedDestinationLng = lng;
    notifyListeners();
  }

  showDriverBottomSheet(BuildContext context) {
    if (alertsOnUi) Navigator.pop(context);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
              height: 400,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(routeModel!.timeNeeded.toString(),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: driverProfile?.avatar == null,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(40)),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 45,
                            child: Icon(
                              Icons.person,
                              size: 65,
                              color: kVistaWhite,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: driverProfile!.avatar != null,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(40)),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(driverProfile?.avatar),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(driverProfile?.profile?.firstName ?? "Driver"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  stars(
                      rating: driverProfile?.rating ?? 5.0,
                      votes: driverProfile?.rating?.toInt() ?? 5),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.directions_car),
                          label: Text(driverProfile!.profile!.rideType!)),
                      Text(driverProfile!.profile!.plateNumber!,
                          style: const TextStyle(color: Colors.deepOrange))
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        onPressed: () {
                          CallsAndMessagesService()
                              .call(driverProfile!.phone ?? "07014261561");
                        },
                        text: "Call",
                        color: Colors.green,
                      ),
                      CustomButton(
                        onPressed: () {
                          // showBottomSheet(
                          //     context: mainContext!,
                          //     builder: (_) {
                          //       return const RideCancelReason();
                          //     });
                        },
                        text: "Cancel",
                        color: Colors.red,
                      )
                    ],
                  )
                ],
              ));
        });
  }

  Future createDeliveryRequest() async {
    clearPoly();
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
      "city": city.text,
      "state": state.text,
      "payment_by": whoFuckingPays.toString(),
      "pickup_time": selectedDate.toString() + selectedTime.toString(),
      // "distance": routeModel!.distance,
      // "duration": routeModel!.timeNeeded,
      "pickup_address": pickUpLocationController.text,
      "dropoff_address": dropOffLocationController.text,
      "payment_method": "card",
      "description": description.text
    };
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;

    try {
      final response = await CallApi().postData(values, 'user/delivery/new');

      final body = response;
      print('delivery sent');
      deliveryId = body['data']['id'];
      print(deliveryId);
      pref.setInt('deliveryId', deliveryId!);
      if (response['success'] == "success") {
        createRoute();
        final body = response;
        print('delivery sent');
        String deliveryId = response['id'];
        print(deliveryId);
        pref.setString('deliveryId', response['id']);
        createRoute();

        print(body);
        if ((body as Map<String, dynamic>).containsKey('id')) {
          pref.setString('deliveryId', body["id"]);
          print(body["id"]);
        } else {
          print('no token added');
        }
      }
      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
    isLoading = false;

    notifyListeners();
  }

  Future updatePaymentMethod() async {
    Map<String, dynamic> values = {
      "delivery_id": deliveryId,
      "payment_method": "cash"
    };
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;
    try {
      final response = await CallApi().postData(values, 'user/delivery/update');
      print(response);
      if (response['success'] == "success") {
        final body = response;
        print('delivery sent');
        String deliveryId = response['id'];
        print(deliveryId);
        pref.setString('deliveryId', response['id']);
        isLoading = false;
        notifyListeners();

        print(body);
        if ((body as Map<String, dynamic>).containsKey('id')) {
          pref.setString('deliveryId', body["id"]);
          print(body["id"]);
        } else {
          print('no token added');
        }
      }
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
      String message = response["message"];
      print(message);
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future submitCashDelivery() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> values = {"payment_method": "cash"};

    try {
      final response =
          await CallApi().postData(values, 'user/delivery/submit/$deliveryId');
      String message = response["message"];
      print(message);
      changeWidgetShowed(showWidget: Show.CASH_PAYMENT);
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

// ANCHOR LISTEN TO DRIVER
  _listenToDrivers() {
    // allDriversStream = _driverService.getDrivers().listen(_updateMarkers);
  }
// trip process endpoint

  Future processDelivery() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      final response =
          await CallApi().postData(null, "user/delivery/process/$deliveryId");
      final body = response;
      print(body);
      print('delivery processing');
      deliveryPrice = response['data']['price'];
      print(deliveryPrice);
      preferences.setString('price', deliveryPrice!);
      if (response['success'] == "success") {
        print(body);
        if ((body as Map<String, dynamic>).containsKey('id')) {
          preferences.setString('deliveryId', body["id"]);
          print(body["id"]);
        } else {
          print('no token added');
        }
        return deliveryPrice;
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//  Timer counter for driver request
  percentageCounter({String? requestId, BuildContext? context}) {
    lookingForDriver = true;
    notifyListeners();
    periodicTimer = Timer.periodic(const Duration(seconds: 1), (time) {
      timeCounter = timeCounter + 1;
      percentage = timeCounter / 100;
      print("====== GOOOO $timeCounter");
      if (timeCounter == 100) {
        timeCounter = 0;
        percentage = 0;
        lookingForDriver = false;
        _requestServices!.updateRequest({"id": requestId, "status": "expired"});
        time.cancel();
        if (alertsOnUi) {
          Navigator.pop(context!);
          alertsOnUi = false;
          notifyListeners();
        }
        requestStream!.cancel();
      }
      notifyListeners();
    });
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

  checkDeliveryStatus() async {
    try {
      final response = await CallApi().getData('user/delivery/$deliveryId');

      final body = response;
      String deliveryStatus = body['data']['status'];
      print(deliveryStatus);

      notifyListeners();
      print(deliveryId);
      if (deliveryStatus == "accepted") {
        changeWidgetShowed(showWidget: Show.DRIVER_FOUND);
      } else {
        return Future.delayed(Duration(seconds: 3), checkDeliveryStatus);
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  getRiderDetails() async {
    try {
      final response = await CallApi().getData('user/delivery/$deliveryId');

      final body = response;
      driverName = body['data']['profile']['first_name'];
      driverPhone = body['data']['profile']['phone'];
      driverPlate = body['data']['profile']['plate_number'];

      print(driverName);
      print(driverPhone);
      print(driverPlate);

      notifyListeners();
    } on SocketException {
      throw const SocketException('No internet connection');
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Timer checkStatusTimer = Timer.periodic(Duration(seconds: 10), (timer) {});

  ///TOFIX
  // void _moveMarkerAndChangeAddress(
  //     {required CameraPosition cameraPosition,
  //     required String markerId,
  //     required String markerTitle}) {
  //   LatLng _point = cameraPosition.target;
  //   _updateLocationMarker(
  //       cameraPosition: cameraPosition,
  //       markerTitle: markerTitle,
  //       markerId: markerId);
  //   _setCoordinates(coordinates: _point);
  //   _getAddressFromCoordinates(point: _point).then((value) async {
  //     _changeAddress(address: address!.name!);
  //   });
  // }

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
      print(error);
    }
  }

  ///tofix
  _setCoordinates({required LatLng coordinates}) {
    if (_isPickupSet == false) {
      pickupCoordinates = coordinates;
    } else {
      destinationCoordinates = coordinates;
    }
    notifyListeners();
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

  _changeAddress({required String address}) async {
    if (_isPickupSet == false) {
      pickUpLocationController.text = address;
    } else {
      dropOffLocationController.text = address;
    }
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

  changeWidgetShowed({Show? showWidget}) {
    show = showWidget!;
    notifyListeners();
  }
}
