

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/extention/extantions.dart';
import '../../../utils/styles/app_text_style.dart';

class LinkScreen extends StatefulWidget {
  const LinkScreen({super.key,required this.title,required this.link});

  final String title;
  final String link;
  @override
  State<LinkScreen> createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 6.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: AppColors.black.withOpacity(0.4),
                  offset: Offset(0, 4)
              )
            ]
        ),
        child:Row(children: [
          Icon(Icons.telegram,size: 22.sp,),
          SizedBox(width: 5.w,),
          Expanded(child: Text(widget.title,style:AppTextStyle.urbanistMedium.copyWith(fontSize: 14.sp),)),
          IconButton(onPressed: (){
            launchURL1(url: widget.link);
          }, icon: Icon(Icons.call_made_sharp,color: AppColors.c257CFF,))
        ],)
    );
  }


}
