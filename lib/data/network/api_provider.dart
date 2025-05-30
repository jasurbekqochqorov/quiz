import 'dart:convert';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/data/model/subject/subject_model.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/data/model/verify_model/verify_model.dart';
import 'package:quiz/data/model/networ_respons_model/network_response.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;

class ApiProvider {
  static Future<NetworkResponse> registerUser(UserModel userModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      Uri uri = Uri.parse("http://174.138.69.45:8000/users/auth/register/");
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(userModel.toJson()),
      );
      // debugPrint("Status Coed: ${response.statusCode} ---------");
      if (response.statusCode == 200) {
        networkResponse.data = "Registered";
      } else if (response.statusCode == 400) {
        debugPrint(
            "Status Coed: ${response.body}-----------------------------------");
        networkResponse.errorText = "this_email_already_registered";
      }
    } catch (error) {
      return NetworkResponse(errorText: error.toString());
    }

    return networkResponse;
  }
  // static Future<NetworkResponse> verifyUser(VerifyModel verifyModel) async {
  //   NetworkResponse networkResponse = NetworkResponse();
  //
  //   try {
  //     Uri uri = Uri.parse("http://dennic.uz:9050/v1/customer/verify");
  //
  //     http.Response response = await http.post(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode(verifyModel.toJson()),
  //     );
  //     if (response.statusCode == 200) {
  //       networkResponse.data = "Logged";
  //     } else if (response.statusCode == 400) {
  //       networkResponse.errorText = "this_number_already_registered";
  //     }
  //   } catch (error) {
  //     return NetworkResponse(errorText: error.toString());
  //   }
  //
  //   return networkResponse;
  // }
  static Future<NetworkResponse> loginUser(LoginModel loginModel) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      Uri uri = Uri.parse("http://174.138.69.45:8000/users/auth/login/");

      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(loginModel.toJson()),
      );
      if (response.statusCode == 200){
        String token=UserModel.fromJson(jsonDecode(response.body)["data"]).accessToken;
        debugPrint("AAAAAAAAAAAAAAAAAAAAAAABORKU$token");
        StorageRepository.setString(key: 'key', value: token);
        networkResponse.data = jsonDecode(response.body)["data"];
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

  // static Future<NetworkResponse> forgetPassword(
  //     {required String phoneNumber}) async {
  //   NetworkResponse networkResponse = NetworkResponse();
  //
  //   try {
  //     Uri uri = Uri.parse("https://swag.dennic.uz/v1/customer/forget-password");
  //
  //     http.Response response = await http.post(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({"phone_number": phoneNumber}),
  //     );
  //     if (response.statusCode == 200) {
  //       networkResponse.data = "of_course";
  //     } else if (response.statusCode == 400) {
  //       networkResponse.errorText = "you haven't registered before";
  //     }
  //   } catch (error) {
  //     networkResponse.errorText = "network error :)";
  //   }
  //
  //   return networkResponse;
  // }

  // static Future<NetworkResponse> verifyOtpCode(
  //     {required String phoneNumber, required int code}) async {
  //   NetworkResponse networkResponse = NetworkResponse();
  //
  //   try {
  //     Uri uri = Uri.parse(
  //         "http://dennic.uz:9050/v1/customer/verify-otp-code?code=$code&phone_number=%2B${phoneNumber.replaceAll("+", "")}");
  //
  //     http.Response response = await http.post(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       networkResponse.data = jsonDecode(response.body);
  //       // debugPrint("${response.body} ----------------");
  //     } else if (response.statusCode == 400) {
  //       networkResponse.errorText = "Time End :)";
  //     }
  //   } catch (error) {
  //     networkResponse.errorText = "network error :)";
  //   }
  //
  //   return networkResponse;
  // }

  static Future<NetworkResponse> updateUserPassword(
      {required String newPassword, required String token}) async {
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
        // debugPrint("${response.body} ----------------");
      } else {
        networkResponse.errorText = response.statusCode.toString();
      }
    } catch (error) {
      networkResponse.errorText = "network error :)";
    }

    return networkResponse;
  }


  static Future<NetworkResponse> getData({required String token}) async {
    try {
      Uri uri = Uri.parse("http://174.138.69.45:8000/tests/paid-test/");

      http.Response response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      debugPrint("KKKKKKKKKKKKKKKKKKKK1");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
      debugPrint("KKKKKKKKKKKKKKKKKKKK2");
        return NetworkResponse(
          data: SubjectModel.fromJson(json),
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
}

