import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverModel {
  String? id;
  String? first_name;
  String? car;
  String? plate;
  String? photo;
  String? phone;
  double? rating;
  int? votes;
  double? lat;
  double? lng;
  double? heading;

  DriverModel(
      {this.id,
      this.first_name,
      this.car,
      this.plate,
      this.photo,
      this.phone,
      this.rating,
      this.votes,
      this.lat,
      this.lng,
      this.heading});

  DriverModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        first_name = json["first_name"],
        car = json["car"],
        plate = json["plate"],
        photo = json["photo"],
        phone = json["phone"],
        rating = json["rating"],
        votes = json["votes"],
        lat = json["lat"],
        lng = json["lng"],
        heading = json["heading"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": first_name,
      "car": car,
      "plate": plate,
      "photo": photo,
      "phone": phone,
      "rating": rating,
      "votes": votes,
      "latitude": lat,
      "longitude": lng,
      "heading": heading
    };
  }

  LatLng getPosition() {
    return LatLng(lat!, lng!);
  }
}
