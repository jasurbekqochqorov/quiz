import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';

class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({super.key, required this.title, this.isButton=false, this.onTap, required this.onPressed});
  final String title;
  final bool? isButton;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 50.h),
      child: Row(children: [
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.w, vertical: 12.h),
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(
                    width: 2.h,
                    color: AppColors.c4F81FF,
                  ))),
          onPressed: onPressed,
          child: SvgPicture.asset(
            AppImages.arrowLeft,
            width: 20.w,
            height: 20.h,
          ),
        ),
        SizedBox(
          width: 16.h,
        ),
        Text(
          title,
          style: AppTextStyle.urbanistMedium
              .copyWith(color: AppColors.black, fontSize: 22.sp),
        ),
        Spacer(),
        (isButton==true)?TextButton(
            style: TextButton.styleFrom(
                padding:EdgeInsets.symmetric(horizontal:10.w,vertical: 13.h),
                backgroundColor:AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  side: BorderSide(width: 2.w,color:AppColors.c257CFF),
                )
            ),
            onPressed:onTap,
            child:Text('Testni yakunlash',style: AppTextStyle.urbanistMedium.copyWith(
                color:AppColors.black,fontSize: 16.sp
            ),)):Text("")
      ],),
    );
  }
}
