class RideRequestModel {
  String? id;
  String? first_name;
  String? user_id;
  String? driverId;
  String? status;
  double? pickup_latitude;
  double? pickup_longitude;
  double? dropoff_latitude;
  double? dropoff_longitude;
  String? ride_type;
  int? estimated_fare;
  int? price;
  String? timeStamp;
  String? payment_status;
  String? payment_method;
  dynamic distance;
  dynamic duration;

  RideRequestModel(
      {this.id,
      this.first_name,
      this.user_id,
      this.status,
      this.pickup_latitude,
      this.pickup_longitude,
      this.dropoff_longitude,
      this.dropoff_latitude,
      this.ride_type,
      this.distance,
      this.duration,
      this.timeStamp,
      this.driverId,
      this.estimated_fare,
      this.payment_method,
      this.payment_status,
      this.price});

  RideRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        first_name = json['first_name'],
        status = json['status'],
        user_id = json['user_id'],
        pickup_latitude = json['pickup_latitude'],
        pickup_longitude = json['pickup_longitude'],
        dropoff_latitude = json['dropoff_latitude'],
        dropoff_longitude = json['dropoff_longitude'],
        ride_type = json['ride_type'],
        distance = json['distance'],
        price = json['price'],
        payment_method = json['payment_method'],
        payment_status = json['payment_status'],
        duration = json['duration'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'status': status,
      'user_id': user_id,
      'pickup_latitude': pickup_latitude,
      'pickup_longitude': pickup_longitude,
      'dropoff_longitude': dropoff_longitude,
      'dropoff_latitude': dropoff_latitude,
      'rode_type': ride_type,
      'distance': distance,
      'duration': duration,
      'price': price,
      'payment_status': payment_status,
      'payment_method': payment_method,
    };
  }
}
