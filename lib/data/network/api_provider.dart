import 'dart:convert';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/data/model/questionMain/question_main_model.dart';
import 'package:quiz/data/model/resultMain/result_main_model.dart';
import 'package:quiz/data/model/userReyting/user_reyting_model.dart';
import 'package:quiz/data/model/user_info/user_info_screen.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/data/model/networ_respons_model/network_response.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import '../model/test_model/test_model.dart';

class ApiProvider {

  static Future<NetworkResponse> sendOtpCode({required String phoneNumber}) async {
    NetworkResponse networkResponse = NetworkResponse();

    debugPrint("Providega keldi${phoneNumber}");
    try {
      Uri uri = Uri.parse(
          "https://pmtests.uz/v1/users/send-sms-code/");

      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body:"""{
        "phone":"$phoneNumber"
        }"""
      );
      debugPrint("Natija:${response.body}");
      if (response.statusCode == 200) {
        networkResponse.data = jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        networkResponse.errorText = "Time End :)";
      }
    } catch (error) {
      networkResponse.errorText = "network error :)";
    }

    return networkResponse;
  }
  static Future<NetworkResponse> checkOtpCode({required String phoneNumber,required int code}) async {
    NetworkResponse networkResponse = NetworkResponse();

    debugPrint("Providega keldi${code}");
    try {
      Uri uri = Uri.parse(
          "https://pmtests.uz/v1/users/check-sms-code/");

      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body:"""{
        "phone":"$phoneNumber",
        "code":$code
        }"""
      );
      debugPrint("Natija:${response.body}");

      if (response.statusCode == 200) {
        networkResponse.data = jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        networkResponse.errorText = "${jsonDecode(response.body)["detail"]}";
      }
    } catch (error) {
      networkResponse.errorText = "network error :)";
    }

    return networkResponse;
  }
  static Future<NetworkResponse> registerUser(UserModel userModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/users/register/");
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(userModel.toJson()),
      );
      if (response.statusCode == 200) {
        networkResponse.data = "Registered";
      } else if (response.statusCode == 400) {
        debugPrint(
            "Status Coed: ${response.body}-----------------------------------");
        networkResponse.errorText = "this_phone_already_registered";
      }
    } catch (error) {
      return NetworkResponse(errorText: error.toString());
    }

    return networkResponse;
  }
  static Future<NetworkResponse> infoUserDetail() async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/users/user-detail-update/");
      http.Response response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${StorageRepository.getString(key: "access")}",
        },
      );
      if (response.statusCode == 200) {
        networkResponse.data=UserInfoModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        networkResponse.errorText = "info nor";
      }
    } catch (error) {
      networkResponse.errorText=error.toString();
    }

    return networkResponse;
  }
  static Future<NetworkResponse> updateUserName({required String firstname,required String lastname}) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/users/user-detail-update/");
      http.Response response = await http.patch(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${StorageRepository.getString(key: "access")}",
        },
        body: """{
        "first_name":"$firstname",
        "last_name":"$lastname"
        }"""
      );
      if (response.statusCode == 200) {
        networkResponse.data=response.body;
      } else if (response.statusCode == 400) {
        networkResponse.errorText = "error";
      }
    } catch (error) {
      networkResponse.errorText=error.toString();
    }

    return networkResponse;
  }
  static Future<NetworkResponse> loginUser(LoginModel loginModel) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/login/");
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(loginModel.toJson()),
      );
      if (response.statusCode == 200){
        String token=jsonDecode(response.body)['access'];
        StorageRepository.setString(key: 'access', value: token);
        networkResponse.data = jsonDecode(response.body);
      } else {
        networkResponse.errorText = "Parol yoki login xato !";
      }
    } catch (error) {
      return NetworkResponse(errorText: error.toString());
    }

    return networkResponse;
  }
  static Future<NetworkResponse> logoutUser({required String token}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      Uri uri = Uri.parse("http://dennic.uz:9050/v1/customer/logout");

      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
      );
      if (response.statusCode == 200) {
        networkResponse.data = "Log out done!";
      } else if (response.statusCode == 270) {
        networkResponse.errorText = "illegal base64 data at input byte 225";
      }
    } catch (error) {
      networkResponse.errorText = "network error :)";
    }

    return networkResponse;
  }
  static Future<NetworkResponse> forgetPassword({required String phoneNumber}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      Uri uri = Uri.parse("https://swag.dennic.uz/v1/customer/forget-password");

      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"phone_number": phoneNumber}),
      );
      if (response.statusCode == 200) {
        networkResponse.data = "of_course";
      } else if (response.statusCode == 400) {
        networkResponse.errorText = "you haven't registered before";
      }
    } catch (error) {
      networkResponse.errorText = "network error :)";
    }

    return networkResponse;
  }
  static Future<NetworkResponse> updateUserPassword({required String newPassword, required String token}) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      Uri uri = Uri.parse(
          "http://dennic.uz:9050/v1/customer/update-password?NewPassword=$newPassword");
      http.Response response = await http.put(
        uri,
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        networkResponse.data = jsonDecode(response.body);
      } else {
        networkResponse.errorText = response.statusCode.toString();
      }
    } catch (error) {
      networkResponse.errorText = "network error :)";
    }

    return networkResponse;
  }
  static Future<NetworkResponse> getData({required int id}) async {
    try {
      Uri uri =(id==0)?Uri.parse("https://pmtests.uz/v1/tests/"):Uri.parse("https://pmtests.uz/v1/tests/?subject_id=$id");
      http.Response response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${StorageRepository.getString(key: "access")}",
        },
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List;
        final tests = decoded.map((e) => TestModel.fromJson(e)).toList();
        return NetworkResponse(
          data: tests,
          errorText:"",
        );
      } else {
        return NetworkResponse(
          errorText: "Server xatosi: ${response.statusCode}",
        );
      }
    } catch (e) {
      return NetworkResponse(
        errorText: "Tarmoq xatosi: $e",
      );
    }
  }
  static Future<NetworkResponse> getQuestion({required String token,required int id}) async {
    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/tests/free-tests/$id/");
      http.Response response = await http.get(
        uri,headers:{
          "Authorization": "Bearer ${StorageRepository.getString(key: "access")}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200){
        final json = jsonDecode(response.body);
        return NetworkResponse(
          data:QuestionMainModel.fromJson(json),
          errorText:"not",
        );
      } else {
        return NetworkResponse(
          errorText: "Server xatosi: ${response.statusCode}",
        );
      }
    } catch (e) {
      return NetworkResponse(
        errorText: "Tarmoq xatosi: $e",
      );
    }
  }

  static Future<NetworkResponse> getResult({required String token,required int id}) async {
    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/tests/see-answers/$id/");
      http.Response response = await http.get(
        uri,headers:{
          "Authorization": "Bearer ${StorageRepository.getString(key: "access")}",
          "Content-Type": "application/json",
        },
      );
        debugPrint("ASD1213${response.body} $id");

        if (response.statusCode == 200){
        final json = jsonDecode(response.body);
        return NetworkResponse(
          data:ResultMainModel.fromJson(json),
          errorText:"not",
        );
      } else {
        return NetworkResponse(
          errorText: "Server xatosi: ${response.statusCode}",
        );
      }
    } catch (e) {
      return NetworkResponse(
        errorText: "Tarmoq xatosi: $e",
      );
    }
  }

  static Future<NetworkResponse> getRating() async {
    try {
      Uri uri = Uri.parse("https://pmtests.uz/v1/users/rating/?p=1&page_size=999999");
      http.Response response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body)["results"] as List;
        final rating=decoded.map((e) => UserRatingModel.fromJson(e as Map<String, dynamic>)).toList();
        return NetworkResponse(
          errorText:"Rating keldi",
          data:rating,
        );
      } else {
        return NetworkResponse(
          errorText: "Server xatosi: ${response.statusCode}",
        );
      }
    } catch (e) {
      return NetworkResponse(
        errorText: "Tarmoq xatosi: $e",
      );
    }
  }




}

