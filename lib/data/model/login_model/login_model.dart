class LoginModel {
  final String fcmToken;
  final String password;
  final String email;
  final String platformName;
  final String platformType;

  LoginModel({
    required this.fcmToken,
    required this.password,
    required this.email,
    required this.platformName,
    required this.platformType,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': fcmToken,
      'password': password,
      'email': email,
      'username': platformName,
      'platform_type': platformType,
    };
  }

  LoginModel copyWith({
    String? fcmToken,
    String? password,
    String? email,
    String? platformName,
    String? platformType,
  }) {
    return LoginModel(
      fcmToken: fcmToken ?? this.fcmToken,
      password: password ?? this.password,
      email: email ?? this.email,
      platformName: platformName ?? this.platformName,
      platformType: platformType ?? this.platformType,
    );
  }
}
