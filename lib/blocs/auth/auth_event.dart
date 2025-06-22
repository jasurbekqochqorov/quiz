import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/verify_model/verify_model.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthenticationEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends AuthEvent {
  LoginUserEvent({required this.loginModel});

  final LoginModel loginModel;

  @override
  List<Object?> get props => [loginModel];
}

class UpdateNameUserEvent extends AuthEvent {
  UpdateNameUserEvent({required this.firstname,required this.lastname});

  final String firstname;
  final String lastname;

  @override
  List<Object?> get props => [firstname,lastname];
}

class InfoUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  RegisterUserEvent({required this.userModel});

  final UserModel userModel;

  @override
  List<Object?> get props => [userModel];
}

class AuthRequestPassword extends AuthEvent {
  AuthRequestPassword({required this.verifyModel});

  final VerifyModel verifyModel;

  @override
  List<Object?> get props => [verifyModel];
}

class LogOutUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthVerifyOtpCoderEvent extends AuthEvent {
  final int code;
  final String phoneNumber;

  AuthVerifyOtpCoderEvent({
    required this.phoneNumber,
    required this.code,
  });

  @override
  List<Object?> get props => [phoneNumber, code];
}

class AuthForgetPasswordEvent extends AuthEvent {
  final String phoneNumber;

  AuthForgetPasswordEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthUpdatePasswordEvent extends AuthEvent {
  final String newPassword;

  AuthUpdatePasswordEvent({required this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}

class SendSmsEvent extends AuthEvent {
  final String phone;

  SendSmsEvent({required this.phone});

  @override
  List<Object?> get props => [phone];
}