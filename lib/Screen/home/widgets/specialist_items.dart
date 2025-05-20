import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpecialistItems extends StatelessWidget {
  const SpecialistItems({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.color1,
    required this.color2,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String subTitle;
  final Color color1;
  final Color color2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Container(
            width: 121.w,
            height: 181.h,
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 24.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [
                  color1,
                  color2,
                ],
              ),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 43.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                ),
                16.getH(),
                Text(
                  textAlign: TextAlign.center,
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                8.getH(),
                Text(
                  textAlign: TextAlign.center,
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        16.getW(),
      ],
    );
  }
}
