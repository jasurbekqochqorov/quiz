import 'package:quiz/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldItems extends StatelessWidget {
  const TextFieldItems({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(
          color: AppColors.c_09101D,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.only(
          left: 28.w,
          top: 12.h,
          bottom: 12.h,
          right: 26.w,
        ),
        filled: true,
        fillColor: AppColors.c_F4F6F9,
        suffixIcon: Icon(
          Icons.search,
          size: 24.sp,
          color: AppColors.c_858C94,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            width: 0.w,
            color: AppColors.c_F4F6F9,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            width: 0.w,
            color: AppColors.c_F4F6F9,
          ),
        ),
      ),
    );
  }
}
