class UserModel {
  UserModel({
    required this.birthDate,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
  });

  final String birthDate;
  final String firstName;
  final String gender;
  final String lastName;
  final String password;
  final String phoneNumber;

  UserModel copyWith({
    String? birthDate,
    String? firstName,
    String? gender,
    String? lastName,
    String? password,
    String? phoneNumber,
  }) =>
      UserModel(
        birthDate: birthDate ?? this.birthDate,
        firstName: firstName ?? this.firstName,
        gender: gender ?? this.gender,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      birthDate: json["birth_date"] as String? ?? "",
      firstName: json["first_name"] as String? ?? "",
      gender: json["gender"] as String? ?? "",
      lastName: json["last_name"] as String? ?? "",
      password: json["password"] as String? ?? "",
      phoneNumber: json["phone_number"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "birth_date": birthDate,
      "first_name": firstName,
      "gender": gender,
      "last_name": lastName,
      "password": password,
      "phone_number": phoneNumber,
    };
  }

  static UserModel initial() => UserModel(
    birthDate: '',
    firstName: '',
    gender: '',
    lastName: '',
    password: '',
    phoneNumber: '',
  );
}
