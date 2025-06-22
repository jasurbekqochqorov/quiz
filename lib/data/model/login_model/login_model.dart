class LoginModel {
  final String fcmToken;
  final String password;
  final String phone;
  final String platformName;
  final String platformType;

  LoginModel({
    required this.fcmToken,
    required this.password,
    required this.phone,
    required this.platformName,
    required this.platformType,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': fcmToken,
      'password': password,
      'phone': phone,
      'username': platformName,
      'platform_type': platformType,
    };
  }

  LoginModel copyWith({
    String? fcmToken,
    String? password,
    String? phone,
    String? platformName,
    String? platformType,
  }) {
    return LoginModel(
      fcmToken: fcmToken ?? this.fcmToken,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      platformName: platformName ?? this.platformName,
      platformType: platformType ?? this.platformType,
    );
  }
}
