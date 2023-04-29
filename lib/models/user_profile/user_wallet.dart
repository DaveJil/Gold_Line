class UserWallet {
 UserWallet({
    this.id,
    this.userId,
    this.balance,
    this.walletType,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? balance;
  String? walletType;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        id: json["id"],
        userId: json["user_id"],
        balance: json["balance"],
        walletType: json["wallet_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "balance": balance,
        "wallet_type": walletType,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
