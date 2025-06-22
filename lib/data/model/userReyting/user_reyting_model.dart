class UserRatingModel {
  UserRatingModel({
    required this.firstname,
    required this.lastname,
    required this.testsRank,
    required this.testsEfficiency
  });

  final String firstname;
  final String lastname;
  final String testsRank;
  final double testsEfficiency;


  UserRatingModel copyWith({
    String? firstname,
    String? lastname,
    String? testsRank,
    double? testsEfficiency
  }) =>
      UserRatingModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        testsRank: testsRank ?? this.testsRank,
        testsEfficiency: testsEfficiency ?? this.testsEfficiency
      );

  factory UserRatingModel.fromJson(Map<String, dynamic> json) {
    return UserRatingModel(
      firstname: json["first_name"] as String? ?? "",
      lastname: json["last_name"] as String? ?? "",
        testsRank: json["tests_rank"] as String? ?? "",
      testsEfficiency: json["tests_efficiency"] as double? ?? 0.0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name":firstname,
      "last_name":lastname,
      "tests_rank":testsRank,
      "tests_efficiency":testsEfficiency
    };
  }

  static UserRatingModel initial() => UserRatingModel(
    firstname: "",
    lastname: "",
    testsRank: "",
    testsEfficiency: 0
  );
}