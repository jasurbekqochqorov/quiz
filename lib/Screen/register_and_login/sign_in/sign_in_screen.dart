import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/data/local/local.dart';
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
import '../../tabbox/tab_box_screen.dart';
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

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNode=FocusNode();

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
                  "Xush kelibsiz!",
                  style: AppTextStyle.urbanistBold.copyWith(
                    color: AppColors.c1D1E25,
                    fontSize: 24.sp,
                  ),
                ),
                8.getH(),
                Text(
                  "Shaxsiy accountingizga kirish",
                  style: AppTextStyle.urbanistRegular.copyWith(
                    color: AppColors.c68DBFF,
                    fontSize: 16.sp,
                  ),
                ),
                70.getH(),
                MyTextFromFieldTel(
                  focusNode: focusNode,
                  regExp: AppConstants.phoneRegExp,
                  errorText: 'Telefon raqam xato',
                  controller: phoneController,
                  labelText: 'Emailingizni kiriting',
                  perefixIcon: AppImages.person,
                  valueChanged: (String value) {
                    if(value.length==9){
                      focusNode.unfocus();
                    }
                    setState(() {});
                  },
                ),
                30.getH(),
                MyTextFromField(
                  errorText: 'Parol xato',
                  regExp: AppConstants.passwordRegExp,
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  onTab: () {
                    setState(() {
                      obthorText = !obthorText;
                    });
                  },
                  labelText: 'Parolingizni kiriting',
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
                      "Parolni unutdingizmi?",
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
                        fcmToken: "",
                        password: passwordController.text,
                        phone: "998${phoneController.text}",
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
                            "Kirish",
                            style: AppTextStyle.urbanistBold.copyWith(
                              fontSize: 18.sp,
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
                      "Account mavjud emasmi?",
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
                        "Ro'yxatdan o'tish",
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
          if (state.formStatus == FormStatus.error) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                _loading=false;
                return AlertDialog(
                  title: Text(state.errorText,),
                );
              },
            );
          }
          if (state.statusMessage=="logged" && state.formStatus==FormStatus.authenticated) {
            StorageRepository.setString(key: "key", value:state.userModel.accessToken);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return TabScreen();
                },
              ),
            );
          }
        },
      ),
    );
  }

}
late AnimationController globalAnimationController;

