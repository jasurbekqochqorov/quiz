import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/data/repositories/auth_repository.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/data/model/networ_respons_model/network_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user_info/user_info_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository appRepository})
      : _appRepository = appRepository,
        super(
          AuthState(
            userInfoModel: UserInfoModel.initial(),
            errorText: "",
            formStatus: FormStatus.pure,
            userModel: UserModel.initial(),
            statusMessage: "",
            userToken: '',
          ),
        ) {
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<SendSmsEvent>(_sendSmsCode);
    on<LogOutUserEvent>(_logOutUser);
    on<AuthForgetPasswordEvent>(_forgetPassword);
    on<AuthUpdatePasswordEvent>(_updatePassword);
    on<AuthVerifyOtpCoderEvent>(_checkSmsCode);
    on<InfoUserEvent>(_infoUser);
    on<UpdateNameUserEvent>(_updateUserName);
  }

  final AuthRepository _appRepository;
  Future<void> _loginUser(LoginUserEvent event, emit) async {
    NetworkResponse networkResponse =
        await _appRepository.loginUser(loginModel: event.loginModel);
    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: "logged",
          formStatus: FormStatus.authenticated,
        ),
      );
    } else {
      emit(
        state.copyWith(
          errorText: networkResponse.errorText,
          formStatus: FormStatus.error,
        ),
      );
    }
  }

  Future<void> _infoUser(InfoUserEvent event, emit) async {
    NetworkResponse networkResponse =
    await _appRepository.infoUser();
    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: "info",
          userInfoModel: networkResponse.data,
          formStatus: FormStatus.authenticated,
        ),
      );
    } else {
      emit(
        state.copyWith(
          errorText: networkResponse.errorText,
          formStatus: FormStatus.error,
        ),
      );
    }
  }
  Future<void> _forgetPassword(AuthForgetPasswordEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();
    emit(state.copyWith(formStatus: FormStatus.loading));

    networkResponse =
    await _appRepository.forgetPassword(phoneNumber: event.phoneNumber);
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
          statusMessage: "forget_password", formStatus: FormStatus.pure));
    } else {
      emit(state.copyWith(
          statusMessage: networkResponse.errorText,
          formStatus: FormStatus.error));
    }
  }

  Future<void> _registerUser(RegisterUserEvent event, emit) async {

    NetworkResponse networkResponse =
        await _appRepository.registerUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
          statusMessage: "registered",
          userModel: event.userModel
        ),
      );
    debugPrint("Qonday");
    } else {
      debugPrint("Error MAkkamik :( ${networkResponse.errorText}");

      if (networkResponse.errorText == "this_email_already_registered") {
        emit(state.copyWith(statusMessage: "this_email_already_registered"));
      } else {
        emit(state.copyWith(errorText: "Register else error"));
      }
    }
  }

  Future<void> _updateUserName(UpdateNameUserEvent event, emit) async {
    NetworkResponse networkResponse =
    await _appRepository.updateUserName(firstname: event.firstname,lastname: event.lastname);
    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
            formStatus: FormStatus.authenticated,
            statusMessage: "name update",
        ),
      );
    } else {
        emit(state.copyWith(statusMessage: "update error"));
    }
    _infoUser;
  }

  Future<void> _sendSmsCode(SendSmsEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    NetworkResponse networkResponse =
        await _appRepository.sendSmsCode(phone: event.phone);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: "query_ok",
        ),
      );
    debugPrint("Qonday");
    } else {
        emit(state.copyWith(errorText: "Not code"));
    }
  }

  Future<void> _checkSmsCode(AuthVerifyOtpCoderEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    NetworkResponse networkResponse =
        await _appRepository.checkSmsCode(phone: event.phoneNumber,code: event.code);
    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: "code tasdiqlandi",formStatus: FormStatus.success
        ),
      );
    } else {
        emit(state.copyWith(errorText:networkResponse.errorText,formStatus:FormStatus.success));
    }
  }


  Future<void> _logOutUser(LogOutUserEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();

    networkResponse = await _appRepository.logoutUser(token: "");
  }

  Future<void> _updatePassword(AuthUpdatePasswordEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();
    emit(state.copyWith(formStatus: FormStatus.loading));

    if (state.userToken.isNotEmpty) {
      networkResponse = await _appRepository.updatePassword(
        newPassword: event.newPassword,
        token: state.userToken,
      );

      if (networkResponse.errorText.isEmpty) {
        emit(
          state.copyWith(
            formStatus: FormStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            statusMessage: "_updatePassword",
            errorText: networkResponse.errorText,
            formStatus: FormStatus.error,
          ),
        );
      }
    }
  }
}
