import 'package:quiz/data/model/user_model/user_model.dart';

import '../../data/model/user_info/user_info_model.dart';

class AuthState {
  const AuthState({
    required this.userToken,
    required this.errorText,
    required this.formStatus,
    required this.userModel,
    required this.statusMessage,
    required this.userInfoModel
  });

  final String errorText;
  final String statusMessage;
  final UserModel userModel;
  final UserInfoModel userInfoModel;
  final FormStatus formStatus;
  final String userToken;

  AuthState copyWith({
    String? errorText,
    FormStatus? formStatus,
    UserModel? userModel,
    UserInfoModel? userInfoModel,
    String? statusMessage,
    String? userToken,
  }) {
    return AuthState(
      userInfoModel: userInfoModel ?? this.userInfoModel,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      userModel: userModel ?? this.userModel,
      formStatus: formStatus ?? this.formStatus,
      userToken: userToken ?? this.userToken,
    );
  }
}

enum FormStatus {
  loading,
  success,
  pure,
  error,
  unauthenticated,
  authenticated,
}