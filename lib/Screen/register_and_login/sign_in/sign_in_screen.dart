import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/constants/app_constants.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../home/home_screen.dart';
import '../forgot_password/forget_password.dart';
import '../forgot_password/new_pasword.dart';
import '../sign_up/sign_up_screen.dart';
import '../widget/my_text_from.dart';
import '../widget/my_text_from_tel.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {
  bool obthorText = true;
  bool _loading = false;
  bool reversAnimation = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.we()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                96.getH(),
                Text(
                  "Welcome Back!",
                  style: AppTextStyle.urbanistBold.copyWith(
                    color: AppColors.c1D1E25,
                    fontSize: 24.sp,
                  ),
                ),
                8.getH(),
                Text(
                  "Sign In to your account",
                  style: AppTextStyle.urbanistRegular.copyWith(
                    color: AppColors.c68DBFF,
                    fontSize: 16.sp,
                  ),
                ),
                70.getH(),
                MyTextFromFieldTel(
                  regExp: AppConstants.phoneRegExp,
                  errorText: 'Phone number error',
                  controller: phoneNumberController,
                  labelText: 'Type your phone',
                  perefixIcon: AppImages.call,
                  valueChanged: (String value) {
                    setState(() {});
                  },
                ),
                30.getH(),
                MyTextFromField(
                  errorText: 'Password error',
                  regExp: AppConstants.passwordRegExp,
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  onTab: () {
                    setState(() {
                      obthorText = !obthorText;
                    });
                  },
                  labelText: 'Type your password',
                  perefixIcon: AppImages.lock,
                  obzorText: obthorText,
                  suffixIcon:
                      obthorText ? AppImages.openEye : AppImages.closeEye,
                  valueChanged: (String value) {
                    // debugPrint(value);

                    setState(() {});
                  },
                ),
                16.getH(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ForgetPassword();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyle.urbanistBold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.c257CFF,
                      ),
                    ),
                  ),
                ),
                73.getH(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r)),
                        backgroundColor: AppColors.c257CFF,
                        padding: EdgeInsets.symmetric(vertical: 15.he())),
                    onPressed: () {
                      _loading = true;
                      setState(() {});

                      LoginModel loginModel = LoginModel(
                        fcmToken: "asdfasdfsaf",
                        password: passwordController.text,
                        phoneNumber: "+998${phoneNumberController.text}",
                        platformName: "mobile",
                        platformType: "mobile",
                      );

                      context.read<AuthBloc>().add(
                            LoginUserEvent(
                              loginModel: loginModel,
                            ),
                          );
                    },
                    child: _loading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Text(
                            "Sign In",
                            style: AppTextStyle.urbanistBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                  ),
                ),
                27.getH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have account?",
                      style: AppTextStyle.urbanistRegular.copyWith(
                        fontSize: 14.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up ",
                        style: AppTextStyle.urbanistBold.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.c257CFF,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state.formStatus == FormStatus.success) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignInScreen();

                },
              ),
            );
          }

          if (state.formStatus == FormStatus.error) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                _loading=false;
                return AlertDialog(
                  title: Text(state.errorText),
                );
              },
            );
          }
          if (state.statusMessage == "token") {
            print("Tokennnnnnn ${state.userToken}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const NewPassworScreen();
                },
              ),
            );
          }

          if (state.statusMessage=="logged") {

            debugPrint("${state.statusMessage=='logged'}  ");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();

                },
              ),
            );
          }
        },
      ),
    );
  }

  bool get _validation {
    return passwordController.text.length > 7 &&
        phoneNumberController.text.length == 13;
  }
}

late AnimationController globalAnimationController;
