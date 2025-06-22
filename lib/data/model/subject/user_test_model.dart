
class UserTestModel{
  final int? id;
  final bool isSolution;
  final bool isSolid;
  final double score;

  UserTestModel({
    required this.id,
    required this.isSolid,
    required this.isSolution,
    required this.score
  });



  Map<String, dynamic> toJson() {
    return {
      "is_solution":isSolution,
      "is_solid":isSolid,
      "score":score
    };
  }

  factory UserTestModel.fromJson(Map<String, dynamic> json) {
    return UserTestModel(
      id: json["id"] as int? ?? 0,
      score: json['score'] as double? ?? 0.0,
      isSolid: json["is_sold"] as bool? ?? false,
      isSolution: json["is_solution"] as bool? ?? false,
    );
  }


  UserTestModel copyWith({
    bool? isSolution,
    bool? isSolid,
    double? score,
    int? id,
  }) {
    return UserTestModel(
      id: id ?? this.id,
        isSolution: isSolution ?? this.isSolution,
      isSolid: isSolid ?? this.isSolid,
      score: score ?? this.score
    );
  }

  static UserTestModel initial() => UserTestModel(
      score: 0.0,
      id: 0,
      isSolid: false,
    isSolution: false
  );
}
