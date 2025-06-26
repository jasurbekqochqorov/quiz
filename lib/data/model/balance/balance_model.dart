class BalanceModel{
  BalanceModel({
    required this.amount,
    required this.payTime,
    required this.test,
  });

  final String amount;
  final String payTime;
  final String test;



  BalanceModel copyWith({
    String? amount,
    String? payTime,
    String? test,
  }) =>
      BalanceModel(
        test: test ?? this.test,
        payTime: payTime ?? this.payTime,
        amount: amount ?? this.amount,
      );

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      amount: json["amount"] as String? ?? "",
      test: json["test"] as String? ?? "",
      payTime: json["pay_time"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "test": test,
      "pay_time": payTime,
    };
  }

  static BalanceModel initial() => BalanceModel(
    amount: '',
    test: "",
    payTime: '',
  );
}