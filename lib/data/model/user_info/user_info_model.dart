
import 'package:quiz/data/model/balance/balance_model.dart';

import '../../userTest/user_test_model.dart';

class UserInfoModel {
  UserInfoModel({
    required this.lastName,
    required this.firstName,
    required this.phone,
    required this.passwordLength,
    required this.rank,
    required this.checkBalance,
    required this.photo,
    required this.userTest,
    required this.balances
  });

  final String firstName;
  final String lastName;
  final String phone;
  final int passwordLength;
  final int rank;
  final double checkBalance;
  final String photo;
  final List<BalanceModel> balances;
  final List<UserTestResultModel> userTest;



  UserInfoModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    int? passwordLength,
    int? rank,
    double? checkBalance,
    String? photo,
    List<UserTestResultModel>? userTest,
    List<BalanceModel>? balances,
  }) =>
      UserInfoModel(
        balances: balances ?? this.balances,
        userTest: userTest ?? this.userTest,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        passwordLength: passwordLength ?? this.passwordLength,
        rank: rank ?? this.rank,
        checkBalance: checkBalance ?? this.checkBalance,
        photo:photo ?? this.photo,
      );

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      balances: (json["balances"] as List<dynamic>).map((e)=>BalanceModel.fromJson(e as Map<String,dynamic>)).toList() as List<BalanceModel>? ??[],
      photo: json["photo"] as String? ??  "",
      phone: json["phone"] as String? ?? "",
      firstName: json["first_name"] as String? ?? "",
      lastName: json["last_name"] as String? ?? "",
      rank: json["rank"] as int? ?? 0,
      checkBalance: json["check_balance"] as double? ?? 0.0,
      passwordLength: json["password_length"] as int? ?? 0,
      userTest: (json["user_test"] as List<dynamic>).map((e)=>UserTestResultModel.fromJson(e as Map<String, dynamic>)).toList() as List<UserTestResultModel>? ?? [],
     );
  }

  Map<String, dynamic> toJson() {
    return {
      "balances" :[],
      "user_test":userTest,
      "first_name": firstName,
      "phone": phone,
      "last_name": lastName,
      "password_length": passwordLength,
      "photo": photo,
      "rank":rank,
      "check_balance":checkBalance,
    };
  }

  static UserInfoModel initial() => UserInfoModel(
    firstName: '',
    balances: [],
    userTest: [],
    lastName: "",
    phone: '',
    passwordLength: 0,
    checkBalance: 0,
    photo: "",
    rank: 0,
  );
}