import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:quiz/Screen/register_and_login/sign_up/widget/check.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
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

import '../verify_code/verify_code_screen.dart';
import '../widget/my_text_from.dart';
import '../widget/my_text_from_tel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerBirthDate = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirm = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String gender = 'male';

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
    const List<String> list = [
      "male",
      "female",
    ];
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
                    "Sign Up",
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
                    controller: controllerFirstName,
                    labelText: 'Type your firstname',
                    perefixIcon: AppImages.person,
                    valueChanged: (String value) {
                      setState(() {});
                    },
                    regExp: AppConstants.textRegExp,
                    errorText: 'First name error',
                  ),
                  10.getH(),
                  MyTextFromField(
                    controller: controllerLastName,
                    labelText: 'Type your lastname',
                    perefixIcon: AppImages.person,
                    valueChanged: (String value) {
                      setState(() {});
                    },
                    regExp: AppConstants.textRegExp,
                    errorText: 'Lastname error',
                  ),
                  20.getH(),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                      setState(() {});
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: SvgPicture.asset(
                          AppImages.calendar,
                          width: 7.w,
                          height: 7.h,
                        ),
                        // border: OutlineInputBorder(),
                      ),
                      child: selectedDate != null
                          ? Text(
                              selectedDate.toString().substring(0, 10),
                              style: AppTextStyle.urbanistBold
                                  .copyWith(color: AppColors.c7E8CA0),
                            )
                          : const Text('Select Date'),
                    ),
                  ),
                  10.getH(),
                  CustomDropdown<String>(
                    hintText: 'Select your gender',
                    items: list,
                    initialItem: list.first,
                    onChanged: (value) {
                      setState(() {});
                      gender = value!;
                    },
                  ),
                  5.getH(),
                  MyTextFromFieldTel(
                    controller: controllerPhoneNumber,
                    labelText: 'Type your phone number',
                    perefixIcon: AppImages.call,
                    valueChanged: (String value) {
                      setState(() {});
                    },
                    errorText: 'Phone number error',
                    regExp: AppConstants.phoneRegExp,
                  ),
                  MyTextFromField(
                    controller: controllerPassword,
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
                    valueChanged: _onChange,
                    regExp: AppConstants.passwordRegExp,
                    errorText: 'Password error',
                  ),
                  10.getH(),
                  MyTextFromField(
                    controller: controllerConfirm,
                    textInputAction: TextInputAction.done,
                    onTab: () {
                      setState(() {
                        obthorText2 = !obthorText2;
                      });
                    },
                    labelText: 'Confirm your password',
                    perefixIcon: AppImages.lock,
                    obzorText: obthorText2,
                    suffixIcon:
                        obthorText2 ? AppImages.openEye : AppImages.closeEye,
                    valueChanged: _onChange,
                    regExp: AppConstants.passwordRegExp,
                    errorText: 'Confirm password error',
                  ),
                  16.getH(),
                  if (write)
                    CheckInput(
                        check: minimumEightcharacters,
                        title: "Minimum 8 characters"),
                  if (write)
                    CheckInput(
                        check: atleastNumber, title: "Atleast 1 number (1-9)"),
                  if (write)
                    CheckInput(
                        check: atleastLowercaseOrUppercaseLetters,
                        title: "Atleast lowercase or uppercase letters"),
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
                            text: "I agree to the company ",
                            style: AppTextStyle.urbanistRegular.copyWith(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                            children: [
                              TextSpan(
                                text: "Term of Service",
                                style: AppTextStyle.urbanistRegular.copyWith(
                                  color: AppColors.c191A26,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: " and",
                                style: AppTextStyle.urbanistRegular.copyWith(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: " Privacy Policy",
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
                        UserModel userMoidel = UserModel(
                          birthDate: selectedDate.toString().substring(0, 10),
                          firstName: controllerFirstName.text,
                          gender: gender,
                          lastName: controllerLastName.text,
                          password: controllerPassword.text,
                          phoneNumber: "+998${controllerPhoneNumber.text}",
                        );

                        if (controllerPhoneNumber.text.isNotEmpty &&
                            controllerLastName.text.isNotEmpty &&
                            controllerFirstName.text.isNotEmpty &&
                            controllerPassword.text.length > 7) {
                          debugPrint("Qonday");

                          if (controllerPassword.text !=
                              controllerConfirm.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Password and Confirm password are not the same",
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
                                "Info error!",
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
                        "Sign Up",
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
            if (state.statusMessage == "this_number_already_registered") {}

            if (state.statusMessage == "registered") {
              debugPrint("registered------------");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyCodeScreen(
                    userModel: UserModel(
                      birthDate: selectedDate.toString().substring(0, 10),
                      firstName: controllerFirstName.text,
                      gender: "male",
                      lastName: controllerLastName.text,
                      password: controllerPassword.text,
                      phoneNumber: "+998${controllerPhoneNumber.text}",
                    ),
                  ),
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
