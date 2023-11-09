import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart'
    as hoc;
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/controllers.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MultipleLocationDelivery extends ChangeNotifier {
  PlaceDetails? pickupLocation;
  PlaceDetails? dropoffLocation1;
  PlaceDetails? dropoffLocation2;
  PlaceDetails? dropoffLocation3;
  PlaceDetails? dropoffLocation4;
  PlaceDetails? dropoffLocation5;

  LatLng? pickUpLatLng;
  LatLng? dropOffLatLng1;
  LatLng? dropOffLatLng2;
  LatLng? dropOffLatLng3;
  LatLng? dropOffLatLng4;
  LatLng? dropOffLatLng5;

  setPickUpLocation(BuildContext context) async {
    var place = await hoc.PlacesAutocomplete.show(
        context: context,
        apiKey: GOOGLE_MAPS_API_KEY,
        mode: hoc.Mode.overlay,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, 'ng')],
        //google_map_webservice package
        onError: (err) {
          print(err);
        });
    notifyListeners();

    if (place != null) {
      // setState(() {
      //   location = place.description.toString();
      // });
      final plist = GoogleMapsPlaces(
        apiKey: GOOGLE_MAPS_API_KEY,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      String placeId = place.placeId ?? "0";
      final details = await plist.getDetailsByPlaceId(placeId);
      print(details);
      multiplePickUpLocationController.text = place.description!;
      print(details);
      // pickUpLocationController.text = details!.result!.formattedAddress!;
      notifyListeners();
      pickupLocation = details.result;
      print(pickupLocation);

      notifyListeners();
    }
    notifyListeners();
    pickUpLatLng = LatLng(pickupLocation!.geometry!.location!.lat!,
        pickupLocation!.geometry!.location!.lng!);
    notifyListeners();
    // pickUpState = await getStateFromCoordinates(point: pickUpLatLng!);
    // pickUpCountry = await getCountryFromCoordinates(point: pickUpLatLng!);
    notifyListeners();
  }

  setDropOffLocation(BuildContext context) async {
    var place = await hoc.PlacesAutocomplete.show(
        context: context,
        apiKey: GOOGLE_MAPS_API_KEY,
        mode: hoc.Mode.overlay,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, 'ng')],
        //google_map_webservice package
        onError: (err) {
          print(err);
        });

    if (place != null) {
      final plist = GoogleMapsPlaces(
        apiKey: GOOGLE_MAPS_API_KEY,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      String placeId = place.placeId ?? "0";
      final details = await plist.getDetailsByPlaceId(placeId);
      print(details);
      dropOffLocationController.text = place.description!;
      print(details);
      // pickUpLocationController.text = details!.result!.formattedAddress!;
      notifyListeners();
      // dropoffLocation = details.result;
      // print(dropoffLocation);

      notifyListeners();
    }
    notifyListeners();
    pickUpLatLng = LatLng(pickupLocation!.geometry!.location!.lat!,
        pickupLocation!.geometry!.location!.lng!);
    notifyListeners();
    // pickUpState = await getStateFromCoordinates(point: pickUpLatLng!);
    // pickUpCountry = await getCountryFromCoordinates(point: pickUpLatLng!);
    notifyListeners();
  }
}
