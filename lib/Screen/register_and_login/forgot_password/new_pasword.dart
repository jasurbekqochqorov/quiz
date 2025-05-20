import 'package:quiz/Screen/register_and_login/forgot_password/password_changed.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/utils/extention/extantions.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/styles/app_text_style.dart';
import '../sign_up/widget/check.dart';
import '../widget/my_text_from.dart';

class NewPassworScreen extends StatefulWidget {
  const NewPassworScreen({super.key});

  @override
  State<NewPassworScreen> createState() => _NewPassworScreenState();
}

class _NewPassworScreenState extends State<NewPassworScreen> {
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirm = TextEditingController();
  bool obthorText = true;
  bool obthorText2 = true;
  bool check = false;
  bool write = false;
  bool minimumEightcharacters = false;
  bool atleastNumber = false;
  bool atleastLowercaseOrUppercaseLetters = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc,AuthState>(builder: (BuildContext context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.we()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  96.getH(),
                  Text(
                    "New Password",
                    style: AppTextStyle.urbanistBold.copyWith(
                      color: AppColors.c1D1E25,
                      fontSize: 24.sp,
                    ),
                  ),
                  8.getH(),
                  Text(
                    "Select verification method and we will send verification code",
                    style: AppTextStyle.urbanistRegular.copyWith(
                      color: AppColors.c808D9E,
                      fontSize: 16.sp,
                    ),
                  ),
                  70.getH(),
                  MyTextFromField(
                    controller: controllerPassword,
                    textInputAction: TextInputAction.done,
                    onTab: () {
                      setState(() {
                        obthorText = !obthorText;
                      });
                    },
                    labelText: 'Type your new password',
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
                        check: atleastNumber,
                        title: "Atleast 1 number (1-9)"),
                  if (write)
                    CheckInput(
                        check: atleastLowercaseOrUppercaseLetters,
                        title: "Atleast lowercase or uppercase letters"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
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
                        AuthUpdatePasswordEvent(
                          newPassword: controllerPassword.text,
                        ),
                      );
                    },
                    child: state.formStatus == FormStatus.loading
                        ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                        : Text(
                      "Confirm New Password",
                      style: AppTextStyle.urbanistBold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );


      }, listener: (BuildContext context, AuthState state) {
        if (state.formStatus == FormStatus.success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PasswordVerifiedScreen();

              },
            ),
          );
        }


      },)
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
}
