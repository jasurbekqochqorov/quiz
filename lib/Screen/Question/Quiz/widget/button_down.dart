import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/data/model/Question/question_model.dart';

import '../../../../data/model/subject/user_test_model.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class ButtonDown extends StatelessWidget {
  const ButtonDown({super.key, required this.onNext, required this.onPrevious, required this.questionModel, required this.activeIndex, });
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final List<QuestionModel> questionModel;
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Visibility(
        visible:(activeIndex>0),
        child: TextButton(
          style:TextButton.styleFrom(
            side: BorderSide(width: 1.r,color: AppColors.black),
              padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 12.h),
              backgroundColor: AppColors.c257CFF,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              )
          ),
          onPressed:onPrevious,
          child: Text('Oldingisi',style: AppTextStyle.urbanistSemiBold.copyWith(
              color: AppColors.white,fontSize: 16.sp
          ),),
        ),
      ),
      Spacer(),
      Visibility(
        visible:activeIndex<questionModel.length-1,
        child: TextButton(
          style:TextButton.styleFrom(
              side: BorderSide(width: 1.r,color: AppColors.black),
              padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 12.h),
              backgroundColor: AppColors.c257CFF,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              )
          ),
          onPressed:onNext,
          child: Text('Keyingisi',style: AppTextStyle.urbanistSemiBold.copyWith(
              color: AppColors.white,fontSize: 16.sp
          ),),
        ),
      ),
    ],);
  }
}
