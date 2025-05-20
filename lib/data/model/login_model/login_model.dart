class LoginModel {
  final String fcmToken;
  final String password;
  final String phoneNumber;
  final String platformName;
  final String platformType;

  LoginModel({
    required this.fcmToken,
    required this.password,
    required this.phoneNumber,
    required this.platformName,
    required this.platformType,
  });

  Map<String, dynamic> toJson() {
    return {
      'fcm_token': fcmToken,
      'password': password,
      'phone_number': phoneNumber,
      'platform_name': platformName,
      'platform_type': platformType,
    };
  }

  LoginModel copyWith({
    String? fcmToken,
    String? password,
    String? phoneNumber,
    String? platformName,
    String? platformType,
  }) {
    return LoginModel(
      fcmToken: fcmToken ?? this.fcmToken,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      platformName: platformName ?? this.platformName,
      platformType: platformType ?? this.platformType,
    );
  }
}
