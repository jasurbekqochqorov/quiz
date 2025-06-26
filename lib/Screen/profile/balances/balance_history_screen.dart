




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz/data/model/balance/balance_model.dart';
import 'package:quiz/utils/images/app_images.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class BalanceHistoryScreen extends StatefulWidget {
  const BalanceHistoryScreen({super.key,required this.balance});
  final List<BalanceModel> balance;
  @override
  State<BalanceHistoryScreen> createState() => _BalanceHistoryScreenState();
}

class _BalanceHistoryScreenState extends State<BalanceHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mening Hisob Tarixim",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 16.sp)),),

      body:(widget.balance.isEmpty)?Center(child:LottieBuilder.asset(AppImages.empty),):SingleChildScrollView(child:Column(children:[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 7.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.white
          ),
          child: Row(
            children: [
            Text("N",style:AppTextStyle.urbanistSemiBold,),
            SizedBox(width: 8.w,),
            Text("Pul miqdori",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp),),
            Spacer(),
              Text("Sana",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp),),
            SizedBox(width: 45.w,),
            Text("Holati",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp)),
            SizedBox(width:45.w,),
          ],),
        ),
        ... List.generate(widget.balance.length,(index){
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.white
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 7.h),
            child:Row(
              children: [
              Text("${index+1}",style:AppTextStyle.urbanistSemiBold.copyWith(fontSize: 14.sp),),
              SizedBox(width: 8.w,),
              Text("+${(widget.balance[index].amount)}",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp,color: Colors.green),),
                Spacer(),
                Text(widget.balance[index].payTime),
              SizedBox(width: 5.w,),
              Text(widget.balance[index].test),
              SizedBox(width: 5.w,),
            ],),
          );
        })
      ],),)
    );

  }
}
