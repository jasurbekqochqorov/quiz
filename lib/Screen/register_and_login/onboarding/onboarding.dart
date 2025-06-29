import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sign_in/sign_in_screen.dart';
import '../sign_up/sign_up_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ClipRRect(
              borderRadius:BorderRadius.circular(290.sp),
              child: Image.network(
                "https://pmtests.uz/static/media/logo.4498d5b43416f763567c.jpg",
                width:250.h,
                height: 250.h,
                fit: BoxFit.cover,
              ),
            ),
          ],),
          Container(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 24.w,
              right: 24.w,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Ushbu ilova “ASSESSMENT DEVELOPMENT” mas’uliyati cheklangan jamiyatga tegishli bo’lib, asosiy faoliyat prezident maktablari, al-Xorazmiy maktabi va boshqa ixtisoslashtirilgan maktablarga tayyorlanayotgan o’quvchilarni foydali qo’llanma va sifatli testlar bilan ta’minlashga yo’naltirilgan.",
                  style: AppTextStyle.urbanistBold.copyWith(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                20.getH(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.c257CFF,
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      }));
                    },
                    child: Text(
                      "Ro'yxatdan o'tish",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                10.getH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Accountingiz Mavjudmi?",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignInScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Kirish",
                        style: TextStyle(
                          color: AppColors.c257CFF,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
