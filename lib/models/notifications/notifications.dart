class NotificationsModel {
  String? id;
  String? title;
  String? message;
  int? image;
  String? role;
  String? navigateTo;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationsModel(
      {this.role,
      this.navigateTo,
      this.message,
      this.image,
      this.id,
      this.updatedAt,
      this.title,
      this.createdAt});

  NotificationsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = json['image'],
        role = json['role'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        message = json['message'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'message': message
    };
  }
}
