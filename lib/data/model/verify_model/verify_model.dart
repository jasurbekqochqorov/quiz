class VerifyModel {
  final int code;
  final String fcmToken;
  final String phoneNumber;
  final String platformName;
  final String platformType;

  VerifyModel({
    required this.code,
    required this.fcmToken,
    required this.phoneNumber,
    required this.platformName,
    required this.platformType,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'fcm_token': fcmToken,
      'phone_number': phoneNumber,
      'platform_name': platformName,
      'platform_type': platformType,
    };
  }
}
