// To parse this JSON data, do
//
//     final DriverProfile = DriverProfileFromJson(jsonString);

import 'dart:convert';

import 'driver_role.dart';
import 'driver_wallet.dart';

DriverProfile driverProfileFromJson(String str) =>
    DriverProfile.fromJson(json.decode(str));

String DriverProfileToJson(DriverProfile data) => json.encode(data.toJson());

class DriverProfile {
  DriverProfile({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.rating,
    this.phoneVerifiedAt,
    this.avatar,
    this.roleId,
    this.avi,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.profile,
    this.wallet,
  });

  String? id;
  String? email;
  dynamic emailVerifiedAt;
  String? phone;
  DateTime? phoneVerifiedAt;
  dynamic avatar;
  double? rating;
  int? roleId;
  dynamic avi;
  DateTime? createdAt;
  DateTime? updatedAt;
  DriverRole? role;
  Profile? profile;
  DriverWallet? wallet;

  factory DriverProfile.fromJson(Map<String, dynamic> json) => DriverProfile(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        rating: json["rating"],
        phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
        avatar: json["avatar"],
        roleId: json["role_id"],
        avi: json["avi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: DriverRole.fromJson(json["role"]),
        profile: Profile.fromJson(json["profile"]),
        wallet: DriverWallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt!.toIso8601String(),
        "avatar": avatar,
        "role_id": roleId,
        "avi": avi,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "role": role!.toJson(),
        "profile": profile!.toJson(),
        "wallet": wallet!.toJson(),
      };
}

class Profile {
  Profile({
    this.id,
    this.DriverId,
    this.firstName,
    this.lastName,
    this.otherName,
    this.address,
    this.lga,
    this.state,
    this.zip,
    this.country,
    this.dob,
    this.online,
    this.gender,
    this.avi,
    this.location,
    this.longitude,
    this.latitude,
    this.rideType,
    this.plateNumber,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? DriverId;
  String? firstName;
  String? lastName;
  String? otherName;
  dynamic address;
  dynamic lga;
  dynamic state;
  dynamic zip;
  dynamic country;
  DateTime? dob;
  int? online;
  String? gender;
  dynamic avi;
  dynamic location;
  dynamic longitude;
  dynamic latitude;
  dynamic rideType;
  dynamic plateNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        DriverId: json["Driver_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        otherName: json["other_name"],
        address: json["address"],
        lga: json["lga"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
        dob: DateTime.parse(json["dob"]),
        online: json["online"],
        gender: json["gender"],
        avi: json["avi"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        rideType: json["ride_type"],
        plateNumber: json["plate_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Driver_id": DriverId,
        "first_name": firstName,
        "last_name": lastName,
        "other_name": otherName,
        "address": address,
        "lga": lga,
        "state": state,
        "zip": zip,
        "country": country,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "online": online,
        "gender": gender,
        "avi": avi,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "ride_type": rideType,
        "plate_number": plateNumber,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
