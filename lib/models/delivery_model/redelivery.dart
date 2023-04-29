// class DeliveryModel {
//   int? id;
//   int? userId;
//   String? driverId;
//   String? receiverName;
//   String? receiverPhone;
//   String? senderName;
//   String? senderPhone;
//   String? status;
//   String? pickupAddress;
//   String? dropOffAddress;
//   String? city;
//   String? state;
//   String? pickupTime;
//   String? type;
//   String? pickupLatitude;
//   String? pickupLongitude;
//   String? dropOffLatitude;
//   String? dropOffLongitude;
//   String? price;
//   double? tip;
//   String? description;
//   String? riderFirstName;
//   String? riderLastName;
//   String? riderPhone;
//   String? riderPlateNumber;
//
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? paymentStatus;
//   String? paymentMethod;
//   dynamic distance;
//   dynamic duration;
//
//   DeliveryModel? managerModel;
//   RiderModel? riderModel;
//
//   DeliveryModel(
//       {this.id,
//         this.status,
//         this.senderPhone,
//         this.senderName,
//         this.receiverPhone,
//         this.receiverName,
//         this.pickupLatitude,
//         this.pickupLongitude,
//         this.dropOffLongitude,
//         this.dropOffLatitude,
//         this.distance,
//         this.description,
//         this.duration,
//         this.driverId,
//         this.updatedAt,
//         this.createdAt,
//         this.pickupAddress,
//         this.city,
//         this.dropOffAddress,
//         this.paymentMethod,
//         this.paymentStatus,
//         this.pickupTime,
//         this.riderPlateNumber,
//         this.riderFirstName,
//         this.price,
//         this.state,
//         this.tip,
//         this.type,
//         this.managerModel, this.riderModel,
//         this.riderPhone,
//         this.riderLastName,
//         this.userId});
//
//   DeliveryModel.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         status = json['status'],
//         userId = json['user_id'],
//         pickupAddress = json['pickup_address'],
//         dropOffAddress = json['dropoff_address'],
//         type = json['type'],
//         price = json['price'],
//         description = json['description'],
//         paymentMethod = json['payment_method'],
//         pickupTime = json['pickup_time'],
//         managerModel = DeliveryManagerModel.fromJson(json['delivery_manager'])
//   paymentStatus = json['payment_status'];
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'sender_name': senderName,
//       'sender_phone': senderPhone,
//       'receiver_name': receiverName,
//       'receiver_phone': receiverPhone,
//       'pickup_longitude': pickupLongitude,
//       'dropoff_longitude': dropOffLongitude,
//       'dropoff_latitude': dropOffLatitude,
//       'city': city,
//       'distance': distance,
//       'duration': duration,
//       'state': state,
//       'payment_status': paymentStatus,
//       'payment_method': paymentMethod,
//       'pickup_address': pickupAddress,
//       'dropoff_address': dropOffAddress,
//     };
//   }
// }
//
// class DeliveryManagerModel {
//   String? managerId, managerPhone, managerFirstName, managerLastName;
//   DeliveryManagerModel(
//       {this.managerId,
//         this.managerFirstName,
//         this.managerLastName,
//         this.managerPhone});
//
//   DeliveryManagerModel.fromJson(Map<String, dynamic> json)
//       : managerId = json['id'],
//         managerPhone = json['phone'],
//         managerFirstName = json['profile']['first_name'],
//         managerLastName = json['profile']['last_name'];
// }
//
//
//
// class RiderModel {
//   String? riderId, riderPhone, riderFirstName, riderLastName;
//   RiderModel(
//       {this.riderId,
//         this.riderFirstName,
//         this.riderLastName,
//         this.riderPhone});
//
//   RiderModel.fromJson(Map<String, dynamic> json)
//       : riderId = json['id'],
//         riderPhone = json['phone'],
//         riderFirstName = json['profile']['first_name'],
//         riderLastName = json['profile']['last_name'];
// }
