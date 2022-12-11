class TransactionModel {
  String? id;
  String? title;
  String? inOut;
  int? amount;
  String? status;
  String? purpose;
  String? user_id;
  String? driver_id;
  String? rider_manager_id;
  DateTime? date;

  TransactionModel(
      {this.amount,
      this.status,
      this.purpose,
      this.user_id,
      this.driver_id,
      this.rider_manager_id,
      this.id,
      this.inOut,
      this.title,
      this.date});

  TransactionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        user_id = json['user_id'],
        amount = json['amount'],
        purpose = json['purpose'],
        driver_id = json['driver_id'],
        date = json['date'],
        rider_manager_id = json['rider_manager_id'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'user_id': user_id,
      'purpose': purpose,
      'amount': amount,
      'driver_id': driver_id,
      'rider_manager_id': rider_manager_id
    };
  }
}
