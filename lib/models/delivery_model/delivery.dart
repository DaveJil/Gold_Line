class DeliveryRequestModel {
  String? id;
  String? userId;
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
  double? pickupLatitude;
  double? pickupLongitude;
  double? dropOffLatitude;
  double? dropOffLongitude;
  double? price;
  double? tip;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? paymentStatus;
  String? paymentMethod;
  dynamic distance;
  dynamic duration;

  DeliveryRequestModel(
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

  DeliveryRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        userId = json['user_id'],
        pickupLatitude = json['pickup_latitude'],
        pickupLongitude = json['pickup_longitude'],
        dropOffLatitude = json['dropoff_latitude'],
        dropOffLongitude = json['dropoff_longitude'],
        type = json['type'],
        distance = json['distance'],
        duration = json['duration'],
        price = json['price'],
        paymentMethod = json['payment_method'],
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
