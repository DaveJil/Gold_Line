import '../api.dart';

class DeliveryRequestServices {
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
