import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart' as compon;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/api_responses/base_api_response.dart';
import '../../models/api_responses/failure.dart';
import '../../models/api_responses/success.dart';
import '../../models/delivery_model/delivery.dart';
import '../../models/driver_model/driver_model.dart';
import '../../models/route_model.dart';
import '../../models/user_profile/user_profile.dart';
import '../../screens/payment_screen/flutterwave_ui_payment.dart';
import '../api.dart';
import '../helpers/constants.dart';
import '../helpers/custom_button.dart';
import '../helpers/routing.dart';
import '../helpers/stars.dart';
import '../services/calls_and_sms.dart';
import '../services/delivery_services.dart';
import '../services/driver_service.dart';
import '../services/map_request.dart';

enum Show { HOME, PAYMENT_METHOD_SELECTION, DRIVER_FOUND, TRIP }

class MapProvider with ChangeNotifier {
  static const ACCEPTED = 'accepted';
  static const CANCELLED = 'cancelled';
  static const PENDING = 'pending';
  static const EXPIRED = 'expired';
  static const PICKUP_MARKER_ID = 'pickup';
  static const LOCATION_MARKER_ID = 'location';
  static const DRIVER_AT_LOCATION_NOTIFICATION = 'DRIVER_AT_LOCATION';
  static const REQUEST_ACCEPTED_NOTIFICATION = 'REQUEST_ACCEPTED';
  static const TRIP_STARTED_NOTIFICATION = 'TRIP_STARTED';

  compon.DetailsResult? pickupLocation;
  compon.DetailsResult? dropoffLocation;

  String? pickUpLocationAddress;
  String? dropOffLocationAddress;

  late LatLng? pickUpLatLng;
  late LatLng? dropOffLatLng;

  FocusNode startFocusNode = FocusNode();
  FocusNode endFocusNode = FocusNode();
  bool _useCurrentLocationPickUp = false;
  bool _useCurrentLocationDropOff = false;

  compon.GooglePlace googlePlace = compon.GooglePlace(GOOGLE_MAPS_API_KEY);
  List<compon.AutocompletePrediction> predictions = [];

  Position? position;
  late bool isLoading = false;
  LatLng? center;
  late LatLng? lastPosition = center;

  LatLng? pickupCoordinates;
  LatLng? destinationCoordinates;
  double? ridePrice = 0;
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

  BitmapDescriptor locationPin = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverPin = BitmapDescriptor.defaultMarker;
  UserProfile? user;

  DriverService _driverService = DriverService();
  Show show = Show.HOME;

  DriverModel? driverModel;
  RouteModel? routeModel;

  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController dropOffLocationController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();

  //  Driver request related variables
  bool lookingForDriver = false;
  bool alertsOnUi = false;
  bool driverFound = false;
  bool driverArrived = false;
  DeliveryRequestServices _requestServices = DeliveryRequestServices();
  int timeCounter = 0;
  double percentage = 0;
  Timer? periodicTimer;
  List<LatLng> polylineCoordinates = [];

  String? requestedDestination;

  //  this variable will listen to the status of the ride request
  StreamSubscription<AsyncSnapshot>? requestStream;
  // this variable will keep track of the drivers position before and during the ride
  StreamSubscription<AsyncSnapshot>? driverStream;
//  this stream is for all the driver on the app
  StreamSubscription<List<DriverModel>>? allDriversStream;

  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

  String? requestStatus = "";
  double? requestedDestinationLat;

  double? requestedDestinationLng;
  DeliveryRequestModel? rideRequestModel;
  BuildContext? mainContext;

  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  MapProvider() {
    _saveDeviceToken();

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
    notifyListeners();

    return center;
  }

  Future<String> getAddressFromCoordinates({required LatLng point}) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(point.latitude, point.longitude);
    String address =
        "${addresses.first.administrativeArea}, ${addresses.first.street}";
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
          // List<Placemark> placemark = await placemarkFromCoordinates(
          //     position.target.latitude, position.target.longitude);
          // pickupLocationController.text = placemark[0].name!;
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

  displayPlacesSearchWidget(BuildContext context) async {
    Prediction? prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: GOOGLE_MAPS_API_KEY,
        mode: Mode.overlay,
        components: [Component(Component.country, "ng")]);
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(prediction!.placeId!);
    double lat = detail.result.geometry!.location.lat;
    double lng = detail.result.geometry!.location.lng;
    LatLng _point = LatLng(lat, lng);

    _changeAddress(address: prediction.description!);
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
    _animateCamera(point: _point);
    notifyListeners();
  }

  Future sendRequest(
      {LatLng? origin, LatLng? destination, UserProfile? user}) async {
    LatLng _org;
    LatLng _dest;

    if (origin == null && destination == null) {
      _org = pickupCoordinates!;
      _dest = destinationCoordinates!;
    } else {
      _org = origin!;
      _dest = destination!;
    }

    RouteModel route =
        await _googleMapsServices.getRouteByCoordinates(_org, _dest);
    routeModel = route;

    if (origin == null) {
      ridePrice =
          double.parse((routeModel!.distance.value! / 500).toStringAsFixed(2));
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
    _createRoute(route.points, color: Colors.deepOrange);
    _createRoute(
      route.points,
    );
    _routeToDestinationPolys = _poly;
    requestDriver(user: user!);

    notifyListeners();
  }

  void updateDestination({String? destination}) {
    dropOffLocationController.text = destination!;
    notifyListeners();
  }

  _createRoute(String decodeRoute, {Color? color}) async {
    clearPoly();
    var uuid = const Uuid();
    String polyId = uuid.v1();

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY, // Your Google Map Key
      PointLatLng(pickupCoordinates!.latitude, pickupCoordinates!.longitude),
      PointLatLng(
          destinationCoordinates!.latitude, destinationCoordinates!.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      notifyListeners();
    }

    // _poly.add(Polyline(
    //     polylineId: PolylineId(polyId),
    //     width: 12,
    //     color: color ?? kPrimaryBlueColor,
    //     onTap: () {},
    //     points: _convertToLatLong(_decodePoly(decodeRoute))));
    // notifyListeners();
  }

  autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      print(result.predictions!.first.description);
      predictions = result.predictions!;
      notifyListeners();
    }
  }


//   List<LatLng> _convertToLatLong(List points) {
//     List<LatLng> result = <LatLng>[];
//     for (int i = 0; i < points.length; i++) {
//       if (i % 2 != 0) {
//         result.add(LatLng(points[i - 1], points[i]));
//       }
//     }
//     return result;
//   }
//
//   List _decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = [];
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
// // repeating until all attributes are decoded
//     do {
//       var shift = 0;
//       int result = 0;
//
//       // for decoding value of one attribute
//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//       /* if value is negetive then bitwise not the value */
//       if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);
//
// /*adding to previous value as done in encoding */
//     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
//
//     print(lList.toString());
//
//     return lList;
//   }

// ANCHOR: MARKERS AND POLYS
  _addLocationMarker(LatLng position, String distance) {
    _markers.add(Marker(
        markerId: const MarkerId(LOCATION_MARKER_ID),
        position: position,
        anchor: const Offset(0, 0.85),
        infoWindow: InfoWindow(
            title: dropOffLocationController.text, snippet: distance),
        icon: locationPin));
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
        icon: locationPin));
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
        icon: driverPin));
    notifyListeners();
  }

  _updateMarkers(List<DriverModel> drivers) {
//    this code will ensure that when the driver markers are updated the location marker wont be deleted
    List<Marker> locationMarkers = _markers
        .where((element) => element.markerId.value == 'location')
        .toList();
    clearMarkers();
    if (locationMarkers.isNotEmpty) {
      _markers.add(locationMarkers[0]);
    }

//    here we are updating the drivers markers
    drivers.forEach((DriverModel driver) {
      _addDriverMarker(
          driverId: driver.id,
          position: LatLng(driver.lat!, driver.lng!),
          rotation: driver.heading);
    });
    notifyListeners();
  }

  _updateDriverMarker(Marker marker) {
    _markers.remove(marker);
    sendRequest(
        origin: pickupCoordinates, destination: driverModel!.getPosition());
    notifyListeners();
    _addDriverMarker(
        position: driverModel!.getPosition(),
        rotation: driverModel!.heading,
        driverId: driverModel!.id);
  }

  _setCustomMapPin() async {
    driverPin = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

    locationPin =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  clearMarkers() {
    _markers.clear();
    notifyListeners();
  }

  _clearDriverMarkers() {
    _markers.forEach((element) {
      String _markerId = element.markerId.value;
      if (_markerId != driverModel!.id ||
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

  _saveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('fcm_token') == null) {
      // firebaseMessaging.requestPermission();
      // String? deviceToken = await firebaseMessaging.getToken();
      // await prefs!.setString('fcm_token', deviceToken!);
    }
  }

  changeRequestedDestination(
      {String? reqDestination, double? lat, double? lng}) {
    requestedDestination = reqDestination;
    requestedDestinationLat = lat;
    requestedDestinationLng = lng;
    notifyListeners();
  }

  listenToRequest(
      {String? id, BuildContext? context, Map<String, dynamic>? json}) async {
    // requestStream = _requestServices!.requestStream().listen((querySnapshot) {
    //   querySnapshot.docChanges.forEach((document) async {
    //     if (document.doc.data()!['id'] == id) {
    //       ///TOFIX
    //       rideRequestModel = RideRequestModel.fromJson(json!);
    //       notifyListeners();
    //       switch (document.doc.data()!['status']) {
    //         case CANCELLED:
    //           break;
    //         case ACCEPTED:
    //           if (lookingForDriver) Navigator.pop(context!);
    //           lookingForDriver = false;
    //           driverModel = await _driverService
    //               .getDriverById(document.doc.data()!['driverId']);
    //           periodicTimer!.cancel();
    //           clearPoly();
    //           _stopListeningToDriversStream();
    //           _listenToDriver(json);
    //           show = Show.DRIVER_FOUND;
    //           notifyListeners();
    //
    //           // showDriverBottomSheet(context!);
    //           break;
    //         case EXPIRED:
    //           showRequestExpiredAlert(context!);
    //           break;
    //         default:
    //           break;
    //       }
    //     }
    //   });
    // });
  }

  showRequestCancelledSnackBar(BuildContext context) {}

  showRequestExpiredAlert(BuildContext context) {
    if (alertsOnUi) Navigator.pop(context);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 200,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("DRIVERS NOT FOUND! \n TRY REQUESTING AGAIN")
                    ],
                  )),
            ),
          );
        });
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
                        visible: driverModel?.photo == null,
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
                        visible: driverModel?.photo != null,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(40)),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(driverModel!.photo!),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(driverModel?.first_name ?? "Driver"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  stars(rating: driverModel!.rating, votes: driverModel!.votes),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.directions_car),
                          label: Text(driverModel!.car!)),
                      Text(driverModel!.plate!,
                          style: const TextStyle(color: Colors.deepOrange))
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        onPressed: () {
                          CallsAndMessagesService().call(driverModel!.phone!);
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

  requestDriver(
      {required UserProfile user,
      double? lat,
      double? lng,
      BuildContext? context,
      Map? distance}) {
    alertsOnUi = true;
    notifyListeners();
    var uuid = const Uuid();
    String id = uuid.v1();
    _requestServices!.createRideRequest(
      user_id: user.id,
      first_name: user.profile!.firstName,
      distance: distance,
      dropoff_latitude: requestedDestinationLat,
      dropoff_longitude: requestedDestinationLng,
      pickup_latitude: lat,
      pickup_longitude: lng,
      dropoff_address: requestedDestination,

      // destination: {
      //   "address": requestedDestination,
      //   "latitude": requestedDestinationLat,
      //   "longitude": requestedDestinationLng
      // },
      // position: {
      //   "latitude": lat,
      //   "longitude": lng
      // }
    );
    listenToRequest(id: id, context: context);
    percentageCounter(requestId: id, context: context);
  }

// cancel trip endpoint
  cancelRequest() async {
    lookingForDriver = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String trip_id = preferences.getString("trip_id")!;
    // _requestServices!
    //     .updateRequest({"id": rideRequestModel!.id, "status": "cancelled"});

    await CallApi().postData({
      "trip_id": trip_id,
      "reason": "",
    }, "user/trip/cancel");

    periodicTimer!.cancel();
    notifyListeners();
  }

// ANCHOR LISTEN TO DRIVER
  _listenToDrivers() {
    // allDriversStream = _driverService.getDrivers().listen(_updateMarkers);
  }
// trip process endpoint
  _processTrip() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String trip_id = preferences.getString("trip_id")!;
    CallApi().postData("", "user/trip/process/$trip_id");
  }

  _listenToDriver(Map<String, dynamic> json) {
    ///Listen to driver
//     driverStream = _driverService.driverStream().listen((event) {
//       event.docChanges.forEach((change) async {
//         if (change.doc.data()!['id'] == driverModel!.id) {
//           driverModel = DriverModel.fromJson(json);
//           // code to update marker
// //          List<Marker> _m = _markers
// //              .where((element) => element.markerId.value == driverModel.id).toList();
// //          _markers.remove(_m[0]);
//           clearMarkers();
//           sendRequest(
//               origin: pickupCoordinates,
//               destination: driverModel!.getPosition());
//           if (routeModel!.distance.value! <= 200) {
//             driverArrived = true;
//           }
//           notifyListeners();
//
//           _addDriverMarker(
//               position: driverModel!.getPosition(),
//               rotation: driverModel!.heading,
//               driverId: driverModel!.id);
//           addPickupMarker(pickupCoordinates!);
//           // _updateDriverMarker(_m[0]);
//         }
//       });
//     });

    show = Show.DRIVER_FOUND;
    notifyListeners();
  }

  _stopListeningToDriversStream() {
    _clearDriverMarkers();
    allDriversStream!.cancel();
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
    pickupLocationController.text = address!;
    if (pickupCoordinates != null) {
      center = pickupCoordinates;
    }
    notifyListeners();
  }

  // ANCHOR PUSH NOTIFICATION METHODS
  Future handleOnMessage(Map<String, dynamic> data) async {
    print("=== data = ${data.toString()}");
    notificationType = data['data']['type'];

    if (notificationType == DRIVER_AT_LOCATION_NOTIFICATION) {
    } else if (notificationType == TRIP_STARTED_NOTIFICATION) {
      show = Show.TRIP;
      sendRequest(
          origin: pickupCoordinates, destination: destinationCoordinates);
      notifyListeners();
    } else if (notificationType == REQUEST_ACCEPTED_NOTIFICATION) {}
    notifyListeners();
  }

  Future handleOnLaunch(
      Map<String, dynamic> data, Map<String, dynamic> json) async {
    notificationType = data['data']['type'];
    if (notificationType == DRIVER_AT_LOCATION_NOTIFICATION) {
    } else if (notificationType == TRIP_STARTED_NOTIFICATION) {
    } else if (notificationType == REQUEST_ACCEPTED_NOTIFICATION) {}
    driverModel = await _driverService.getDriverById(data['data']['driverId']);
    _stopListeningToDriversStream();

    _listenToDriver(json);
    notifyListeners();
  }

  Future handleOnResume(Map<String, dynamic> data) async {
    notificationType = data['data']['type'];

    _stopListeningToDriversStream();
    if (notificationType == DRIVER_AT_LOCATION_NOTIFICATION) {
    } else if (notificationType == TRIP_STARTED_NOTIFICATION) {
    } else if (notificationType == REQUEST_ACCEPTED_NOTIFICATION) {}

    if (lookingForDriver) Navigator.pop(mainContext!);
    lookingForDriver = false;
    driverModel = await _driverService.getDriverById(data['data']['driverId']);
    periodicTimer!.cancel();
    notifyListeners();
  }

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
  // _setCoordinates({required LatLng coordinates}) {
  //   if (_isPickupSet == false) {
  //     pickupCoordinates = coordinates;
  //   } else {
  //     destinationCoordinates = coordinates;
  //   }
  //   notifyListeners();
  // }
  //
  // _setCountryCode() {
  //   countryCode = address!.country;
  //   notifyListeners();
  // }

  _addMarker(
      {required LatLng markerPosition,
      required String id,
      required String title}) {
    markers.add(Marker(
        markerId: MarkerId(id),
        position: markerPosition,
        zIndex: 10,
        infoWindow: InfoWindow(title: title),
        icon: locationPin));
    notifyListeners();
  }

  _changeAddress({required String address}) async {
    if (_isPickupSet == false) {
      pickupLocationController.text = address;
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

  // sumbit trip
  Future submitTrip() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response = await CallApi().getData("user/trip/submit/$trip_id");

    if (response["code"] == "success") {
      print(response["data"]);
      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }

  // sumbit trip
  Future calculatePrice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response =
        await CallApi().postData(null, "user/trip/process/$trip_id");
    if (response["code"] == "success") {
      String price = response["price"];
      initPayment(price);
      print(response["data"]);
      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }

  // sumbit trip
  Future initPayment(String price) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response =
        await CallApi().postData(null, "user/trip/initialize-payment/$trip_id");
    if (response["code"] == "success") {
      String ref_id = response["ref_id"];
      changeScreen(
          mainContext!,
          FlutterwavePaymentScreen(
              price: price,
              email: user!.email!,
              phone: user!.phone!,
              ref_id: ref_id));

      print(response["data"]);
      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }

  // cancel trip
  Future cancelTrip(String? reason) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response = await CallApi().postData(
        {"trip_id": trip_id, "reason": reason}, "api/user/trip/cancel");

    if (response["code"] == "success") {
      print(response["data"]);
      changeScreenReplacement(mainContext!, const MapWidget());

      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }

  // cancel trip
  Future rateTrip(String? comment, int? votes) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response = await CallApi().postData(
        {"trip_id": trip_id, "comment": comment, "rating": votes},
        "user/trip/cancel");

    if (response["code"] == "success") {
      print(response["data"]);
      changeScreenReplacement(mainContext!, const MapWidget());

      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }

// get verify payment
  Future<BaseApiResponse> getVerifyPayment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response =
        await CallApi().getData("user/trip/verify-payment/$trip_id");

    if (response["code"] == "success") {
      print(response["data"]);
      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }

// get view trip
  Future<Object> viewTrip() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final trip_id = pref.getString("trip_id");

    final response = await CallApi().getData("user/trip/$trip_id");

    if (response["code"] == "success") {
      print(response["data"]);
      return Success(data: response["data"], message: "${response["message"]}");
    } else {
      print(response["data"]);
      return Failure(
          errorData: response["data"], message: "${response["message"]}");
    }
  }
}
