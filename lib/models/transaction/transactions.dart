import 'package:intl/intl.dart';

class Transactions {
  int? id;
  String? inout;
  String? title;
  String? amount;
  int? orderId;
  DateTime? createdAt;

  Transactions(
      {this.id,
      this.inout,
      this.title,
      this.amount,
      this.orderId,
      this.createdAt});

  Transactions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        inout = json['inout'],
        title = json['title'],
        amount = json['amount'],
        orderId = json['order_id'],
        createdAt = DateFormat('yyyy-MM-dd').parse(json["created_at"]);
}
