import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.questionVariant, required this.variant, required this.isActive, required this.isTrue, required this.isTrue2,});
  final String questionVariant;
  final String variant;
  final bool isActive;
  final bool isTrue;
  final bool isTrue2;
  @override
  State<Questions> createState() => _QuestionsButtonState();
}

class _QuestionsButtonState extends State<Questions> {

  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.only(
          left: 10.w,top: 13.h,bottom: 13.h,right: 10.w
      ),
      decoration: BoxDecoration(
      color:(widget.isActive)?((widget.isTrue)?Colors.green:Colors.red):(widget.isTrue2)?AppColors.c257CFF:AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: double.infinity,
      child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.questionVariant,style: AppTextStyle.urbanistSemiBold.copyWith(
                  color: AppColors.black,fontSize: 15.sp
              ),),
              Expanded(
                child: Text(widget.variant,style: AppTextStyle.urbanistSemiBold.copyWith(
                    color: AppColors.black,fontSize:16.sp
                ),),
              ),
            ],
          )
    );
  }

}
