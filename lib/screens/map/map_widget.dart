import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold_line/screens/bottom_sheets/order_status.dart';
import 'package:gold_line/screens/bottom_sheets/searching%20for%20driver.dart';
import 'package:gold_line/screens/map/widgets/driver_found.dart';
import 'package:gold_line/screens/map/widgets/home_container.dart';
import 'package:gold_line/screens/payment_screen/cash_payment%20screen.dart';
import 'package:gold_line/screens/payment_screen/flutterwave_ui_payment.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/map_provider.dart';
import '../../utility/providers/user_provider.dart';
import '../bottom_sheets/trip_bottom_sheet.dart';
import 'widgets/checkout_bottom.dart';

class MapWidget extends StatefulWidget {
  final LatLng? pickupLatLng;
  final LatLng? dropoffLatLng;

  const MapWidget({Key? key, this.pickupLatLng, this.dropoffLatLng})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              MapScreen(scaffoldState),
              Visibility(
                visible: mapProvider.show == Show.DRIVER_FOUND,
                child: Positioned(
                    top: 60,
                    left: 15,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: mapProvider.driverArrived
                                ? Container(
                                    color: Colors.green,
                                    child: const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        "Meet driver at the pick up location",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: kPrimaryGoldColor,
                                    child: const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        "Meet driver at the pick up location",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )),
              ),
              Visibility(
                visible: mapProvider.show == Show.TRIP,
                child: Positioned(
                    top: 60,
                    left: MediaQuery.of(context).size.width / 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: kPrimaryGoldColor,
                            child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                      text:
                                          "You will reach your destination in \n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                  TextSpan(
                                      text: mapProvider.routeModel?.timeNeeded
                                              .toString() ??
                                          "",
                                      style: const TextStyle(fontSize: 22)),
                                ]))),
                          ),
                        ],
                      ),
                    )),
              ),
              // ANCHOR Draggable
              Visibility(
                  visible: mapProvider.show == Show.HOME,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: HomeContainer())),
              // ANCHOR PICK UP WIDGET
              //  ANCHOR Draggable PAYMENT METHOD

              Visibility(
                  visible: mapProvider.show == Show.FLUTTERWAVE_PAYMENT,
                  child: FlutterwavePaymentScreen(
                    scaffoldState: scaffoldState,
                  )),
              //  ANCHOR Draggable DRIVER

              Visibility(
                  visible: mapProvider.show == Show.CASH_PAYMENT,
                  child: CashPaymentWidget()),

              Visibility(
                  visible: mapProvider.show == Show.DRIVER_FOUND,
                  child: DriverFoundWidget()),

              //  ANCHOR Draggable DRIVER
              Visibility(
                  visible: mapProvider.show == Show.TRIP,
                  child: TripBottomSheet()),

              Visibility(
                  visible: mapProvider.show == Show.CHECKOUT_DELIVERY,
                  child: SummaryWidget()),

              Visibility(
                  visible: mapProvider.show == Show.SEARCHING_FOR_DRIVER,
                  child: SearchingForDriverSheet()),

              Visibility(
                  visible: mapProvider.show == Show.ORDER_STATUS,
                  child: OrderStatusWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  const MapScreen(this.scaffoldState, {Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);

  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return mapProvider.center == null
        ? SpinKitCircle(
            color: kPrimaryGoldColor,
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: mapProvider.center!, zoom: 15),
                  onMapCreated: mapProvider.onCreate,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  compassEnabled: true,
                  rotateGesturesEnabled: true,
                  onCameraMove: mapProvider.onCameraMove,
                  polylines: mapProvider.poly,
                  markers: mapProvider.markers),
            ],
          );
  }
}
