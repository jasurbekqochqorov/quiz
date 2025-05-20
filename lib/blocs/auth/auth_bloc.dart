import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/data/repositories/auth_repository.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/data/model/networ_respons_model/network_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository appRepository})
      : _appRepository = appRepository,
        super(
          AuthState(
            errorText: "",
            formStatus: FormStatus.pure,
            userModel: UserModel.initial(),
            statusMessage: "",
            userToken: '',
          ),
        ) {
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<CheckAuthenticationEvent>(_checkAuthenticationUser);
    on<LogOutUserEvent>(_logOutUser);
    on<AuthRequestPassword>(_check);
    on<AuthForgetPasswordEvent>(_forgetPassword);
    on<AuthVerifyOtpCoderEvent>(_verifyOtpCode);
    on<AuthUpdatePasswordEvent>(_updatePassword);
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

  Future<void> _check(AuthRequestPassword even, emit) async {
    NetworkResponse networkResponse =
        await _appRepository.registerUserVerify(verifyModel: even.verifyModel);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: "query_ok",
        ),
      );
    } else {
      debugPrint("Error :(");

      if (networkResponse.errorText == "this_number_already_registered") {
        emit(state.copyWith(statusMessage: "this_number_already_registered"));
      } else {
        emit(state.copyWith(errorText: "Register else error"));
      }
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
        ),
      );
    debugPrint("Qonday");
    } else {
      debugPrint("Error MAkkamik :( ${networkResponse.errorText}");

      if (networkResponse.errorText == "this_number_already_registered") {
        emit(state.copyWith(statusMessage: "this_number_already_registered"));
      } else {
        emit(state.copyWith(errorText: "Register else error"));
      }
    }
  }

  Future<void> _checkAuthenticationUser(
      CheckAuthenticationEvent event, emit) async {}

  Future<void> _logOutUser(LogOutUserEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();

    networkResponse = await _appRepository.logoutUser(token: "");
  }

  Future<void> _verifyOtpCode(AuthVerifyOtpCoderEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();
    emit(state.copyWith(formStatus: FormStatus.loading));

    networkResponse = await _appRepository.verifyOtpCodeUser(
      phoneNumber: event.phoneNumber,
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {
      debugPrint("ALLLLLLLLLLLL"+networkResponse.data["token"].toString());
      emit(
        state.copyWith(
            userToken: networkResponse.data["token"],
            statusMessage: "token",
            formStatus: FormStatus.pure),
      );
    } else {
      emit(state.copyWith(
          errorText: networkResponse.errorText, formStatus: FormStatus.error));
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
