import '../api.dart';

class DeliveryRequestServices {
  String collection = "requests";

  void createRideRequest({
    String? user_id,
    String? first_name,
    String? status,
    double? pickup_latitude,
    double? pickup_longitude,
    double? dropoff_latitude,
    double? dropoff_longitude,
    String? pickup_address,
    String? dropoff_address,
    bool? paymentMethod,
    String? ride_type,
    dynamic distance,
    dynamic duration,
    String? ride_for,
  }) {
    Map<String, dynamic> values = {
      "user_id": user_id,
      "driverId": "",
      "status": 'pending',
      "distance": distance,
      "duration": duration,
      "pickup_longitude": pickup_longitude,
      "pickup_latitude": pickup_latitude,
      "dropoff_latitude": dropoff_latitude,
      "dropoff_longitude": dropoff_latitude,
      "ride_type": ride_type,
      "ride_for": ride_for,
      "pickup_addres": pickup_address,
      "payment_method": paymentMethod.toString()
    };

    CallApi().postData(values, 'user/trip/new');
  }

  void updateRequest(Map<String, dynamic> values) {
    String? trip_request_id;
    CallApi().updateData(values, "user/trip/update");
  }

// Stream<AsyncSnapshot> requestStream() {
//   CollectionReference reference =
//       FirebaseFirestore.instance.collection(collection);
//   return reference.snapshots();
// }
}
