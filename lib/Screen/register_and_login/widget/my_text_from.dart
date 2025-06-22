import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyTextFromField extends StatelessWidget {
  const MyTextFromField({
    super.key,
    this.focusNode,
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
  });

  final FocusNode? focusNode;
  final String labelText;
  final String errorText;
  final RegExp regExp;
  final bool obzorText;
  final String perefixIcon;
  final String? suffixIcon;
  final VoidCallback? onTab;
  final TextInputAction textInputAction;
  final ValueChanged<String> valueChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: perefixIcon.contains("call")
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      maxLength: perefixIcon.contains("call") ? 8 : null,
      onChanged: valueChanged,
      textInputAction: textInputAction,
      style: AppTextStyle.urbanistBold.copyWith(
        fontSize: 14.sp,
        color: AppColors.c191A26,
      ),
      validator: (String? value) {
        if (value == null || value.length < 3 || !regExp.hasMatch(value)) {
          return errorText;
        } else {
          return null;
        }
      },
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obzorText,
      decoration: InputDecoration(
        focusedBorder:OutlineInputBorder(
         borderSide: BorderSide(
           width: 1.sp,
           color: AppColors.c257CFF
         ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.sp
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.sp
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.c257CFF,
            width: 1.we(),
          ),
        ),

        label: Text(
          labelText,
          style: AppTextStyle.urbanistRegular.copyWith(
            fontSize: 14.sp,
            color: AppColors.c_7E8CA0,
          ),
        ),
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
                child: SvgPicture.asset(
                  perefixIcon,
                ),
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
