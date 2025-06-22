class CoinModel {
  final String name;
  final String balance;
  final int coin;

  CoinModel({
    required this.coin,
    required this.name,
    required this.balance,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      name: json["username"] as String? ?? "",
      balance: json["balance"] as String? ?? "",
      coin: json["coins"] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "coins":0,
      'username':name,
      "balance":""
    };
  }

  CoinModel copyWith({
    String? name,
    String? balance,
    int? coin,
  }) {
    return CoinModel(
      name: name ?? this.name,
      balance: balance ?? this.balance,
      coin: coin ?? this.coin
    );
  }

  static CoinModel initial() => CoinModel(
      name: "",
      balance: "",
      coin: 0
  );
}
