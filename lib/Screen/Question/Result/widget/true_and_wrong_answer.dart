import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';


class TrueAndWrong extends StatelessWidget {
  const TrueAndWrong({super.key, required this.color, required this.title});
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical:5.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color:color,
        ),
        child: Center(child: Text(title,style: AppTextStyle.urbanistSemiBold.copyWith(
          color: AppColors.white,fontSize: 15.sp
        ),)),
      ),);
  }
}
