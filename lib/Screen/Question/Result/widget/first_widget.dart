import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';

class FirstWidget extends StatelessWidget {
  const FirstWidget({super.key, required this.title, required this.color, this.isVisible=false});
  final String title;
  final Color color;
  final bool? isVisible;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(width: 1.r,color: AppColors.black)
      ),
      padding: EdgeInsets.symmetric(vertical:10.h),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Visibility(
              visible: isVisible!,
              child: Icon(Icons.change_circle_outlined)),
          SizedBox(width: 5.w,),
          Text(title,style: AppTextStyle.urbanistSemiBold.copyWith(
              color: AppColors.white,fontSize: 20.sp
          ),),
        ],)
      ),
    );
  }
}
