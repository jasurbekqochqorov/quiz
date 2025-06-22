import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';
import '../../../../utils/utility_functions.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key, required this.onTap, required this.k});
  final VoidCallback onTap;
  final int k;
  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,right: 0,
        child:Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight:Radius.circular(20.r),topLeft: Radius.circular(20.r)),
              color:AppColors.c1D1E25.withOpacity(0.9)
          ),
          padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 20.h),
          child:Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 12.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 2.h,color: AppColors.white)
              ),
              child: Row(children: [
                SvgPicture.asset(AppImages.watch,width: 17.w,height: 20.h,),
                SizedBox(width: 5.sp,),
                Text(getMinutelyText(widget.k),style: AppTextStyle.urbanistMedium.copyWith(
                    color: AppColors.white,fontSize:16.sp
                ),)
              ],),
            ),
            Spacer(),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor:AppColors.c257CFF,
                    padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),

                    ),
                  side: BorderSide(width:2.w,color: AppColors.white)
                ),
                onPressed:widget.onTap, child:Text('Testni boshlash',style: AppTextStyle.urbanistMedium.copyWith(
                color: AppColors.white,fontSize:16.sp
            ),))
          ],),
        ));
  }
}
