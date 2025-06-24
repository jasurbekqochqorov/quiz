import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/model/subject/user_test_model.dart';
import '../../../../data/model/test_model/test_model.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';


class Information extends StatefulWidget {
  const Information({super.key, required this.subjectModel, required this.progressValue, required this.title});
  final TestModel subjectModel;
  final double progressValue;
  final String title;

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Text(widget.subjectModel.title,maxLines: 2,style: AppTextStyle.urbanistRegular.copyWith(
                color: AppColors.black,fontSize: 12.sp,
              ),),
            ),
            Icon(Icons.watch_later,color: AppColors.black,size: 22.sp,),
            SizedBox(width:7.w,),
            Text(widget.title,style: AppTextStyle.urbanistMedium.copyWith(
              color: AppColors.c257CFF,fontSize:16.sp,
            ),),
          ],),
          SizedBox(height: 14.h,),
          LinearProgressIndicator(
            value:widget.progressValue,
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.c4F81FF,
            backgroundColor: AppColors.c1D1E25,
          ),

        ],
      ),
    );
  }
}
