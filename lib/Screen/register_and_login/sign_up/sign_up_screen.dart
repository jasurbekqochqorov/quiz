import 'package:quiz/Screen/register_and_login/sign_in/sign_in_screen.dart';
import 'package:quiz/Screen/register_and_login/sign_up/widget/check.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/constants/app_constants.dart';
import 'package:quiz/utils/extention/extantions.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widget/my_text_from.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword1 = TextEditingController();
  TextEditingController controllerPassword2 = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obthorText = true;
  bool obthorText2 = true;
  bool check = false;
  bool write = false;
  bool minimumEightcharacters = false;
  bool atleastNumber = false;
  bool atleastLowercaseOrUppercaseLetters = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFFF,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppImages.arrowLeft,
            width: 24.we(),
            height: 24.he(),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.we()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.getH(),
                  Text(
                    "Ro'yxatdan o'tish",
                    style: AppTextStyle.urbanistBold.copyWith(
                      color: AppColors.c1D1E25,
                      fontSize: 24.sp,
                    ),
                  ),
                  8.getH(),
                  Text(
                    "Create account and enjoy all services",
                    style: AppTextStyle.urbanistRegular.copyWith(
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  8.getH(),
                  MyTextFromField(
                    controller: controllerUsername,
                    labelText: 'Ismingizni yozing',
                    perefixIcon: AppImages.person,
                    valueChanged: (String value) {
                      setState(() {});
                    },
                    regExp: AppConstants.textRegExp,
                    errorText: 'First name error',
                  ),
                  10.getH(),
                  MyTextFromField(
                    controller: controllerEmail,
                    labelText: 'Emailingizni yozing',
                    perefixIcon: AppImages.person,
                    valueChanged: (String value) {
                      setState(() {});
                    },
                    regExp: AppConstants.emailRegExp,
                    errorText: 'Email error',
                  ),
                  20.getH(),
                  MyTextFromField(
                    controller: controllerPassword1,
                    textInputAction: TextInputAction.done,
                    onTab: () {
                      setState(() {
                        obthorText = !obthorText;
                      });
                    },
                    labelText: 'Parol kiriting',
                    perefixIcon: AppImages.lock,
                    obzorText: obthorText,
                    suffixIcon:
                        obthorText ? AppImages.openEye : AppImages.closeEye,
                    valueChanged: _onChange,
                    regExp: AppConstants.passwordRegExp,
                    errorText: 'Parol yaroqli emas',
                  ),
                  10.getH(),
                  MyTextFromField(
                    controller: controllerPassword2,
                    textInputAction: TextInputAction.done,
                    onTab: () {
                      setState(() {
                        obthorText2 = !obthorText2;
                      });
                    },
                    labelText: 'Parolingizni tasdiqlang',
                    perefixIcon: AppImages.lock,
                    obzorText: obthorText2,
                    suffixIcon:
                        obthorText2 ? AppImages.openEye : AppImages.closeEye,
                    valueChanged: _onChange,
                    regExp: AppConstants.passwordRegExp,
                    errorText: 'Parollar mos emas',
                  ),
                  16.getH(),
                  if (write)
                    CheckInput(
                        check: minimumEightcharacters,
                        title: "Minimum 8 ta belgi bo'lsin"),
                  if (write)
                    CheckInput(
                        check: atleastNumber, title: "Raqamlar ham bo'lsin"),
                  if (write)
                    CheckInput(
                        check: atleastLowercaseOrUppercaseLetters,
                        title: "Katta yoki kichik harflar ham qatnashsin"),
                  16.getH(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox.adaptive(
                            side: BorderSide(
                                color: AppColors.cCBD5E0,
                                width: check ? 0 : 1.2.w),
                            checkColor: AppColors.cFFFFFF,
                            activeColor: AppColors.c257CFF,
                            value: check,
                            onChanged: (v) {
                              check = !check;
                              setState(() {});
                            }),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Men sizning kompaniyangizning",
                            style: AppTextStyle.urbanistRegular.copyWith(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                            children: [
                              TextSpan(
                                text: " Hamma shartlariga",
                                style: AppTextStyle.urbanistRegular.copyWith(
                                  color: AppColors.c191A26,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: " va",
                                style: AppTextStyle.urbanistRegular.copyWith(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: " Qonun qoidalariga roziman",
                                style: AppTextStyle.urbanistRegular.copyWith(
                                  color: AppColors.c191A26,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  42.getH(),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                          backgroundColor: AppColors.c257CFF,
                          padding: EdgeInsets.symmetric(vertical: 15.he())),
                      onPressed: () {
                        StorageRepository.setString(key: "name", value:controllerUsername.text);
                        UserModel userMoidel = UserModel(
                          accessToken: "",
                          username: controllerUsername.text,
                          email: controllerEmail.text,
                          password1: controllerPassword1.text,
                          password2: controllerPassword2.text,
                        );

                        if (controllerUsername.text.isNotEmpty &&
                            controllerEmail.text.isNotEmpty &&
                            controllerPassword2.text.length>7 &&
                            controllerPassword1.text.length > 7) {
                          debugPrint("Qonday");

                          if (controllerPassword1.text !=
                              controllerPassword2.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Parollar mos emas",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            context.read<AuthBloc>().add(
                                  RegisterUserEvent(userModel: userMoidel),
                                );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Malumotlar hammsini to'ldiring!",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Ro'yxatdan o'tish",
                        style: AppTextStyle.urbanistBold.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.cFFFFFF,
                        ),
                      ),
                    ),
                  ),
                  20.getH(),
                ],
              ),
            );
          },
          listener: (BuildContext context, AuthState state) {
            if (state.statusMessage == "this_email_already_registered") {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Center(child: Text("Bu email allaqchon ro'yxatdan o'tgan",style: AppTextStyle.urbanistBold.copyWith(color: AppColors.white),)),)
              );}

            if (state.statusMessage == "registered") {
              debugPrint("registered------------");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _onChange(String value) {
    write = true;
    if (value.length > 7) {
      minimumEightcharacters = true;
    }
    if (value.length < 7) {
      minimumEightcharacters = false;
    }
    if (value.isDigitMy()) {
      atleastNumber = true;
    }
    if (!value.isDigitMy()) {
      atleastNumber = false;
    }
    if (value.isAlphaMy()) {
      atleastLowercaseOrUppercaseLetters = true;
    }
    if (!value.isAlphaMy()) {
      atleastLowercaseOrUppercaseLetters = false;
    }
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
