class UserModel {
  UserModel({
    required this.accessToken,
    required this.email,
    required this.username,
    required this.password1,
    required this.password2,
  });

  final String accessToken;
  final String email;
  final String username;
  final String password1;
  final String password2;

  UserModel copyWith({
    String? email,
    String? accessToken,
    String? username,
    String? password1,
    String? password2,
  }) =>
      UserModel(
        accessToken: accessToken ?? this.accessToken,
        email: email ?? this.email,
        username: username ?? this.username,
        password1: password1 ?? this.password1,
        password2: password2 ?? this.password2,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json["access_token"] as String ?? "",
      email: json["email"] as String? ?? "",
      username: json["username"] as String? ?? "",
      password1: json["password1"] as String? ?? "",
      password2: json["password2"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token":accessToken,
      "email": email,
      "username": username,
      "password1": password1,
      "password2": password2,
    };
  }

  static UserModel initial() => UserModel(
    accessToken: "",
    username: '',
    email: '',
    password1: '',
    password2: '',
  );
}
