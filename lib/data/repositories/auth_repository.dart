import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/data/network/api_provider.dart';
import '../model/networ_respons_model/network_response.dart';

class AuthRepository {
  Future<NetworkResponse> infoUser() async =>
      await ApiProvider.infoUserDetail();

  Future<NetworkResponse> registerUser({required UserModel userModel}) async =>
      await ApiProvider.registerUser(userModel);

  Future<NetworkResponse> updateUserName({required String firstname,required String lastname}) async =>
      await ApiProvider.updateUserName(firstname: firstname,lastname: lastname);


  Future<NetworkResponse> sendSmsCode({required String phone}) async =>
      await ApiProvider.sendOtpCode(phoneNumber: phone);

 Future<NetworkResponse> checkSmsCode({required String phone,required int code}) async =>
      await ApiProvider.checkOtpCode(phoneNumber: phone,code: code);

  // Future<NetworkResponse> registerUserVerify(
  //     {required VerifyModel verifyModel}) async =>
  //     await ApiProvider.verifyUser(verifyModel);

  Future<NetworkResponse> loginUser({required LoginModel loginModel}) async =>
      await ApiProvider.loginUser(loginModel);

  Future<NetworkResponse> logoutUser({required String token}) async =>
      await ApiProvider.logoutUser(token: token);

  Future<NetworkResponse> forgetPassword({required String phoneNumber}) async =>
      await ApiProvider.forgetPassword(phoneNumber: phoneNumber);

  // Future<NetworkResponse> verifyOtpCodeUser(
  //     {required String phoneNumber, required int password}) async =>
  //     await ApiProvider.verifyOtpCode(phoneNumber: phoneNumber, code: password);

  Future<NetworkResponse> updatePassword(
      {required String newPassword, required String phone}) async =>
      await ApiProvider.updateUserPassword(
          newPassword: newPassword,phone:phone);
}