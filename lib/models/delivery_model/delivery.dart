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
  String? pickupTime;
  String? pickupLatitude;
  String? pickupLongitude;
  String? dropOffLatitude;
  String? dropOffLongitude;
  String? price;
  String? tip;
  String? description;
  String? type;
  String? riderFirstName;
  String? riderLastName;
  String? riderPhone;
  String? riderPlateNumber;
  String? paymentStatus;
  String? paymentMethod;
  String? paymentBy;

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
      this.description,
      this.driverId,
      this.pickupAddress,
      this.dropOffAddress,
      this.paymentMethod,
      this.paymentStatus,
      this.pickupTime,
      this.paymentBy,
      this.riderPlateNumber,
      this.riderFirstName,
      this.riderLastName,
      this.riderPhone,
      this.price,
      this.tip,
      this.type,
      this.userId});

  DeliveryModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        status = json['status'],
        userId = json['user_id'],
        pickupAddress = json['pickup_address'],
        dropOffAddress = json['dropoff_address'],
        receiverName = json['receiver_name'],
        receiverPhone = json['receiver_phone'],
        senderName = json['sender_name'],
        senderPhone = json['sender_phone'],
        type = json['type'],
        price = json['price'],
        description = json['description'],
        paymentMethod = json['payment_method'],
        pickupTime = json['pickup_time'],
        riderLastName = (json['rider'] == null)
            ? 'Rider Not assigned Yet'
            : (json['rider']['profile'] == null)
                ? 'RiderNotAssigned Yet'
                : json['rider']['profile']['last_name'],
        riderFirstName = (json['rider'] == null)
            ? 'Rider Not assigned Yet'
            : (json['rider']['profile'] == null)
                ? 'RiderNotAssigned Yet'
                : json['rider']['profile']['first_name'],
        riderPhone = (json['rider'] == null)
            ? 'Rider Not assigned Yet'
            : (json['rider']['profile'] == null)
                ? 'RiderNotAssigned Yet'
                : json['rider']['phone'],
        riderPlateNumber = (json['rider'] == null)
            ? 'Rider Not assigned Yet'
            : (json['rider']['profile'] == null)
                ? 'Rider Not assigned Yet'
                : json['rider']['profile']['plate_number'],
        paymentBy = json['payment_by'],
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
      'payment_status': paymentStatus,
      'payment_method': paymentMethod,
      'pickup_address': pickupAddress,
      'dropoff_address': dropOffAddress,
    };
  }
}

class DeliveryManagerModel {
  int? managerId;

  String? managerPhone, managerFirstName, managerLastName;
  DeliveryManagerModel(
      {this.managerId,
      this.managerFirstName,
      this.managerLastName,
      this.managerPhone});

  DeliveryManagerModel.fromJson(dynamic json)
      : managerId = json['id'] ?? "",
        managerPhone = json['phone'] ?? "",
        managerFirstName = json['profile']['first_name'] ?? "",
        managerLastName = json['profile']['last_name'] ?? "";
}

class RiderModel {
  int? riderId;
  String? riderPhone, riderFirstName, riderLastName;
  RiderModel(
      {this.riderId, this.riderFirstName, this.riderLastName, this.riderPhone});

  RiderModel.fromJson(dynamic json)
      : riderId = json['id'] ?? "",
        riderPhone = json['phone'] ?? "",
        riderFirstName = json['profile']['first_name'] ?? "",
        riderLastName = json['profile']['last_name'] ?? "";
}
