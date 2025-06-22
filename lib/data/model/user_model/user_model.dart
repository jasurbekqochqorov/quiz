class UserModel {
  UserModel({
    required this.accessToken,
    required this.lastName,
    required this.firstName,
    required this.phone,
    required this.password,
    required this.showPassword,
  });

  final String accessToken;
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String showPassword;

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? accessToken,
    String? phone,
    String? password,
    String? showPassword,
  }) =>
      UserModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        accessToken: accessToken ?? this.accessToken,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        showPassword: showPassword ?? this.showPassword,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json["access_token"] as String ?? "",
      phone: json["phone"] as String ?? "",
      firstName: json["first_name"] as String? ?? "",
      lastName: json["last_name"] as String? ?? "",
      password: json["password"] as String? ?? "",
      showPassword: json["show_password"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token":accessToken,
      "first_name": firstName,
      "phone": phone,
      "last_name": lastName,
      "password": password,
      "show_password": showPassword,
    };
  }

  static UserModel initial() => UserModel(
    accessToken: "",
    firstName: '',
    lastName: "",
    phone: '',
    password: '',
    showPassword: '',
  );
}
