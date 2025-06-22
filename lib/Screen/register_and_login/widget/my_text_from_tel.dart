import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyTextFromFieldTel extends StatelessWidget {
  const MyTextFromFieldTel({
    super.key,
    required this.labelText,
    this.obzorText = false,
    required this.perefixIcon,
    this.suffixIcon,
    this.onTab,
    this.textInputAction = TextInputAction.next,
    required this.valueChanged,
    required this.controller,
    required this.regExp,
    required this.errorText,
    required this.focusNode
  });

  final String labelText;
  final RegExp regExp;
  final String errorText;
  final bool obzorText;
  final String perefixIcon;
  final String? suffixIcon;
  final VoidCallback? onTab;
  final TextInputAction textInputAction;
  final ValueChanged<String> valueChanged;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      controller: controller,
      inputFormatters: perefixIcon.contains("call")
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      maxLength: 9,
      onChanged: valueChanged,
      textInputAction: textInputAction,
      style: AppTextStyle.urbanistBold.copyWith(
        fontSize: 14.sp,
        color: AppColors.c191A26,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
          return errorText;
        } else {
          return null;
        }
      },
      obscureText: obzorText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.c257CFF,
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.cE9ECF2,
            width: 1.w,
          ),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.w,
          ),),
        errorBorder:OutlineInputBorder(
      borderSide: BorderSide(
      color: Colors.red,
        width: 1.w,
      ),),
        label: Text(
          "Telefon raqamingizni yozing",
          style: AppTextStyle.urbanistRegular.copyWith(
            fontSize: 14.sp,
            color: AppColors.c7E8CA0,
          ),
        ),
        prefixText: "+998",
        prefixIcon: perefixIcon.contains("png")
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(""),
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.we(), vertical: 10.we()),
                child: SvgPicture.asset(perefixIcon, height: 20.h, width: 20.w),
              ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onTab,
                icon: SvgPicture.asset(suffixIcon!),
              )
            : null,
      ),
    );
  }
}
