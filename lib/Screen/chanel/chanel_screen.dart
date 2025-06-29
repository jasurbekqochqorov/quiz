

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/chanel/widgets/link_screen.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/extention/extantions.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ChanelScreen extends StatefulWidget {
  const ChanelScreen({super.key});

  @override
  State<ChanelScreen> createState() => _ChanelScreenState();
}

class _ChanelScreenState extends State<ChanelScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Kanallarimiz",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 18.sp),),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
        child: Column(children: [
          LinkScreen(title:"Repetitsion testlar ingliz tili kanali", link: "https://t.me//pmtests_admin"),
          LinkScreen(title:"Prezident va Al-Xorazmiy maktablariga tayyorlov", link: "https://t.me//pmtests_admin"),
          LinkScreen(title:"Repetitsion testlar kanali", link: "https://t.me//pmtests_admin"),
          LinkScreen(title:"Prezident maktabi (imtihoniga tayyorgarlik) testlari kanali", link: "https://t.me/pmtests"),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            ZoomTapAnimation(
              onTap: (){
                launchURL1(url:"https://t.me/pmtests/");
              },
              child: Icon(Icons.telegram,color: Colors.blue,size: 35.sp,),
            ),
            ZoomTapAnimation(
              onTap: (){
                launchURL1(url: "https://www.instagram.com/pmtests.uz/");
              },
              child: Image.asset(AppImages.instagram,width: 35.w,height: 35.h,),
            ),
            ZoomTapAnimation(
              onTap: (){
                launchURL1(url: "https://www.facebook.com/pmtests.uz");
              },
              child:Icon(Icons.facebook,color: Colors.blue,size: 35.sp,),
            ),
            ZoomTapAnimation(
              onTap: (){
                launchURL1(url: "https://www.youtube.com/@pmtests-1");
              },
              child:Image.asset(AppImages.youtube,width: 40.w,height: 40.h,),
            ),
          ],)
        ],),
      ),
    );
  }
}
