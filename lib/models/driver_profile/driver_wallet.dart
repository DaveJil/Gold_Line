class DriverWallet {
  DriverWallet({
    this.id,
    this.driverId,
    this.balance,
    this.walletType,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? driverId;
  String? balance;
  String? walletType;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DriverWallet.fromJson(Map<String, dynamic> json) => DriverWallet(
        id: json["id"],
        driverId: json["user_id"],
        balance: json["balance"],
        walletType: json["wallet_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": driverId,
        "balance": balance,
        "wallet_type": walletType,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
