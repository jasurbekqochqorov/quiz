import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: AppColors.c_242B42,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Reset Password",
              style: AppTextStyle.urbanistBold
                  .copyWith(color: AppColors.c_111827, fontSize: 24.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Enter your phone number, we will send a verification code to email",
              style: AppTextStyle.urbanistRegular
                  .copyWith(color: AppColors.c808D9E, fontSize: 16.sp),
            ),
            SizedBox(
              height: 26.h,
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Type your phone number",
                    style: AppTextStyle.urbanistRegular
                        .copyWith(color: AppColors.c808D9E, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "+6282332877994",
                    style: AppTextStyle.urbanistBold
                        .copyWith(color: AppColors.c191A26, fontSize: 14.sp),
                  )
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    backgroundColor: AppColors.c257CFF,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r))),
                child: Text(
                  "Send Link",
                  style: AppTextStyle.urbanistBold
                      .copyWith(color: AppColors.white, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
