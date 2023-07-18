class GetData {
  String? firstName;
  String? lastName;
  String? email;
  String? uuid;
  String? avatar;
  String? appRole;
  String? phone;

  GetData({this.email, this.lastName, this.firstName, this.uuid, this.avatar, this.appRole, this.phone
  });

  GetData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        lastName = json["profile"]['last_name'],
        firstName = json['profile']['first_name'],
        avatar = json['avatar'],
  appRole = json['app_role'],
  phone = json['phone'],
        uuid = json["uuid"];
}
