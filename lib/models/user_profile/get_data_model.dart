class GetData {
  String? firstName;
  String? lastName;
  String? email;
  String? uuid;
  String? avatar;

  GetData({this.email, this.lastName, this.firstName, this.uuid, this.avatar});

  GetData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        lastName = json["profile"]['last_name'],
        firstName = json['profile']['first_name'],
        uuid = json["uuid"];
}
