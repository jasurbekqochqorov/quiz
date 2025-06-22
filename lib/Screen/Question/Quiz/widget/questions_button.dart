import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class QuestionsButton extends StatefulWidget {
  const QuestionsButton({super.key, required this.questionVariant, required this.variant, required this.onTap, required this.isActive,});
  final String questionVariant;
  final String variant;
  final VoidCallback onTap;
  final bool isActive;
  @override
  State<QuestionsButton> createState() => _QuestionsButtonState();
}

class _QuestionsButtonState extends State<QuestionsButton> {

  @override
  void initState() {
   // _check();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      width: double.infinity,
      child: TextButton(
          style: TextButton.styleFrom(
            side: BorderSide(width: 2.sp,color:(widget.isActive)?AppColors.c257CFF:AppColors.black),
              padding: EdgeInsets.only(
                  left: 10.w,top: 13.h,bottom: 13.h,right: 10.w
              ),
               backgroundColor:(widget.isActive)?AppColors.c257CFF:AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              )
          ),
          onPressed:widget.onTap,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Text(widget.questionVariant,style: AppTextStyle.urbanistMedium.copyWith(
                color:(widget.isActive)?AppColors.white:AppColors.c1D1E25,fontSize: 15.sp
              ),),
              Expanded(
                child: Text(widget.variant,style: AppTextStyle.urbanistRegular.copyWith(
                    color:(widget.isActive)?AppColors.white:AppColors.c1D1E25,fontSize:16.sp
                ),),
              ),
            ],
          )),
    );
  }

}
