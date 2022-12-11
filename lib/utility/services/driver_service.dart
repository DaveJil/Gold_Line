import 'dart:convert';

import '../../models/driver_model/driver_model.dart';
import '../api.dart';

class DriverService {
  CallApi callApi = CallApi();
  String collection = 'drivers';

  // Stream<List<DriverModel>> getDrivers() {
  //   return firebaseFirestore.collection(collection).snapshots().map(
  //       (event) => event.docs.map((e) => DriverModel.fromSnapshot(e)).toList());
  // }

  Future<DriverModel> getDriverById(String id) async {
    final response = await CallApi().getData('trip_request');
    var body = jsonDecode(response);
    return DriverModel.fromJson(body['driver_id']);
  }

  // Stream<QuerySnapshot> driverStream() {
  //   CollectionReference reference =
  //       FirebaseFirestore.instance.collection(collection);
  //   return reference.snapshots();
  // }
}
