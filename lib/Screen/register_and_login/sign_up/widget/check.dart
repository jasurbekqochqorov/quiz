import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';

class CheckInput extends StatelessWidget {
  const CheckInput({super.key, required this.check, required this.title});

  final bool check;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              check ? AppImages.done : AppImages.cansel,
              width: 16.we(),
              height: 16.we(),
            ),
            12.getW(),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.urbanistRegular.copyWith(
                  color: AppColors.c808D9E,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
