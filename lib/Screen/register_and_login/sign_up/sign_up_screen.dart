import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_event.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/constants/app_constants.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../forgot_password/forgot_verify_code_screen.dart';
import '../widget/my_text_from.dart';
import '../widget/my_text_from_tel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerFamilyName = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode focusNode=FocusNode();
  UserModel userModel=UserModel.initial();
  final formKey = GlobalKey<FormState>();
  bool check = false;

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
        child:SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.we()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              Text(
                "Ro'yxatdan o'tish",
                style: AppTextStyle.urbanistBold.copyWith(
                  color: AppColors.c1D1E25,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 20.h,),
              MyTextFromField(
                controller: controllerUsername,
                labelText: 'Ismingizni yozing',
                perefixIcon: AppImages.person,
                valueChanged: (String value) {
                  setState(() {});
                },
                regExp: AppConstants.textRegExp,
                errorText: "Ushbu maydon to'ldirilishi shart",
              ),
              10.getH(),
              MyTextFromField(
                controller: controllerFamilyName,
                labelText: 'Familyangiznni  yozing',
                perefixIcon: AppImages.person,
                valueChanged: (String value) {
                  setState(() {});
                },
                regExp: AppConstants.textRegExp,
                errorText: "Ushbu maydon to'ldirilishi shart",
              ),
              20.getH(),
              MyTextFromFieldTel(
                regExp: AppConstants.phoneRegExp,
                errorText: 'Telefon raqam xato',
                controller: phoneController,
                labelText: 'Telofon raqamingizni kiriting',
                perefixIcon: AppImages.person,
                valueChanged: (String value) {
                  if(value.length==9){
                    focusNode.unfocus();
                  }
                  setState(() {});
                },
                focusNode: focusNode,
              ),
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
                    userModel = userModel.copyWith(
                      accessToken: "",
                      firstName: controllerUsername.text,
                      lastName: controllerFamilyName.text,
                      phone: "998${phoneController.text}"
                    );
                    if (controllerUsername.text.isNotEmpty &&
                        controllerFamilyName.text.isNotEmpty && phoneController.text.isNotEmpty){
                      context.read<AuthBloc>().add(SendSmsEvent(phone: "998${phoneController.text}"));
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return ForgotVerifyCodeScreen(userModel,phone: "998${phoneController.text}",);
                      }));
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
                    "Keyingisi",
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
        ),
      ),
    );
  }
}