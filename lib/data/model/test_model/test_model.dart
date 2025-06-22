import 'package:quiz/data/model/subject/user_test_model.dart';

class TestModel{
  final int id;
  final String image;
  final String title;
  final String price;
  final String discountPrice;
  final bool isSale;
  final bool isFree;
  final int duration;
  final int questionCount;
  final UserTestModel userTestModel;


  TestModel({
    required this.userTestModel,
    required this.discountPrice,
    required this.id,
    required this.title,
    required this.image,
    required this.isFree,
    required this.price,
    required this.questionCount,
    required this.duration,
    required this.isSale
  });



  Map<String, dynamic> toJson() {
    return {
      "discount_price":discountPrice,
      "image":image,
      'id': id,
      'title': title,
      'price': price,
      'duration': duration,
      'is_sale': isSale,
      "is_free":isFree,
      "question_count":questionCount,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      userTestModel: UserTestModel.fromJson(json["user_test"] as Map<String,dynamic>) as UserTestModel? ?? UserTestModel.initial(),
      image: json["image"] as String? ?? "",
      isSale: json["is_sale"] as bool? ?? false,
      id: json["id"] as int? ?? 0,
      title: json["title"] as String? ?? "",
      price: json["price"] as String? ?? "",
      duration: json["duration"] as int? ?? 0,
      discountPrice: json["discount_price"] as String? ?? "",
      questionCount: json["questions_count"] as int? ?? 0,
      isFree: json['is_free'] as bool? ?? false,
    );
  }


  TestModel copyWith({
    String? image,
    String? title,
    int? id,
    String? price,
    int? questionCount,
    bool? isSale,
    bool? isFree,
    int? duration,
    String? discountPrice,
    UserTestModel? userTestModel
  }) {
    return TestModel(
      userTestModel:userTestModel ?? this.userTestModel,
        isFree: isFree ?? this.isFree,
      image: image ?? this.image,
      duration: duration ?? this.duration,
      isSale: isSale ?? this.isSale,
      id: id ?? this.id,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      questionCount: questionCount ?? this.questionCount,
      title: title ?? this.title
    );
  }

  static TestModel initial() => TestModel(
    isSale: false,
    userTestModel: UserTestModel.initial(),
    image:"",
    title: '',
    discountPrice: '',
    price: '',
    questionCount: 0,
    duration: 0,
    isFree: false,
      id: 0
  );
}
