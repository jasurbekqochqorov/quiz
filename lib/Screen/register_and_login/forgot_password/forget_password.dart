import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/styles/app_text_style.dart';
import '../widget/my_text_from_tel.dart';
import 'forgot_verify_code_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

TextEditingController controllerPhoneNumber = TextEditingController();

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.we()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                96.getH(),
                Text(
                  "Forgot Password",
                  style: AppTextStyle.urbanistBold.copyWith(
                    color: AppColors.c1D1E25,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 8.h,),
                Text(
                  "Select verification method and we will send verification code",
                  style: AppTextStyle.urbanistRegular.copyWith(
                    color: AppColors.c808D9E,
                    fontSize: 16.sp,
                  ),
                ),
                70.getH(),
                MyTextFromFieldTel(
                  regExp: AppConstants.phoneRegExp,
                  errorText: 'Phone number error',
                  controller: controllerPhoneNumber,
                  labelText: 'Type your phone',
                  perefixIcon: AppImages.call,
                  valueChanged: (String value) {
                    setState(() {});
                  },
                ),
                400.getH(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r)),
                        backgroundColor: AppColors.c257CFF,
                        padding: EdgeInsets.symmetric(vertical: 15.he())),
                    onPressed: state.formStatus == FormStatus.loading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  AuthForgetPasswordEvent(
                                      phoneNumber:
                                          "+998${controllerPhoneNumber.text}"),
                                );
                          },
                    child: state.formStatus == FormStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Text(
                            "Send Code",
                            style: AppTextStyle.urbanistBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state.statusMessage == "forget_password") {
            debugPrint("CODE");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ForgotVerifyCodeScreen(
                    phoneNumber: "+998${controllerPhoneNumber.text}",
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
