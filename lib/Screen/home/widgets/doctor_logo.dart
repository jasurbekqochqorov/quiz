import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorLogo extends StatelessWidget {
  const DoctorLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 9.h,
        horizontal: 11.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.r),
        gradient: const LinearGradient(
          colors: [
            AppColors.c_2972FE,
            AppColors.c_6499FF,
          ],
        ),
      ),
      child: SvgPicture.asset(
        AppImages.belll,
        width: 14.w,
        height: 17.h,
      ),
    );
  }
}
