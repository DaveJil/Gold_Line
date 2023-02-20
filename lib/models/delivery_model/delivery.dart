class DeliveryModel {
  int? id;
  int? userId;
  String? driverId;
  String? receiverName;
  String? receiverPhone;
  String? senderName;
  String? senderPhone;
  String? status;
  String? pickupAddress;
  String? dropOffAddress;
  String? city;
  String? state;
  String? pickupTime;
  String? type;
  String? pickupLatitude;
  String? pickupLongitude;
  String? dropOffLatitude;
  String? dropOffLongitude;
  String? price;
  double? tip;
  String? description;

  DateTime? createdAt;
  DateTime? updatedAt;
  String? paymentStatus;
  String? paymentMethod;
  dynamic distance;
  dynamic duration;

  DeliveryModel(
      {this.id,
      this.status,
      this.senderPhone,
      this.senderName,
      this.receiverPhone,
      this.receiverName,
      this.pickupLatitude,
      this.pickupLongitude,
      this.dropOffLongitude,
      this.dropOffLatitude,
      this.distance,
      this.description,
      this.duration,
      this.driverId,
      this.updatedAt,
      this.createdAt,
      this.pickupAddress,
      this.city,
      this.dropOffAddress,
      this.paymentMethod,
      this.paymentStatus,
      this.pickupTime,
      this.price,
      this.state,
      this.tip,
      this.type,
      this.userId});

  DeliveryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        userId = json['user_id'],
        pickupAddress = json['pickup_address'],
        dropOffAddress = json['dropoff_address'],
        type = json['type'],
        price = json['price'],
        description = json['description'],
        paymentMethod = json['payment_method'],
        pickupTime = json['pickup_time'],
        paymentStatus = json['payment_status'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_name': senderName,
      'sender_phone': senderPhone,
      'receiver_name': receiverName,
      'receiver_phone': receiverPhone,
      'pickup_longitude': pickupLongitude,
      'dropoff_longitude': dropOffLongitude,
      'dropoff_latitude': dropOffLatitude,
      'city': city,
      'distance': distance,
      'duration': duration,
      'state': state,
      'payment_status': paymentStatus,
      'payment_method': paymentMethod,
      'pickup_address': pickupAddress,
      'dropoff_address': dropOffAddress,
    };
  }
}
