


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/data/userTest/user_test_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/styles/app_text_style.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key,required this.userTestResultModel});
  final List<UserTestResultModel> userTestResultModel;
  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mening testlarim",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 16.sp)),),

      body:SingleChildScrollView(child:Column(children:[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 7.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.white
          ),
          child: Row(children: [
            Text("N",style:AppTextStyle.urbanistSemiBold,),
            SizedBox(width: 8.w,),
            Expanded(child: Text("Test nomi",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp),)),
            Spacer(),
            Text("Sana",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp),),
            SizedBox(width: 5.w,),
            Text("Narxi",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp)),
            SizedBox(width: 5.w,),
            Text("Ball",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp)),
            SizedBox(width: 5.w,),
          ],),
        ),
        ... List.generate(widget.userTestResultModel.length,(index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.white
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 7.h),
            child:Row(children: [
              Text("${index+1}",style:AppTextStyle.urbanistSemiBold,),
              SizedBox(width: 8.w,),
              Expanded(child: Text(widget.userTestResultModel[index].title,style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp),)),
              Spacer(),
              Text(widget.userTestResultModel[index].testTime),
              SizedBox(width: 5.w,),
              Text(widget.userTestResultModel[index].price),
              SizedBox(width: 5.w,),
              Text((widget.userTestResultModel[index].price.isEmpty)?"Bepul":widget.userTestResultModel[index].price,style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp),),
              SizedBox(width: 5.w,),
              RichText(text:TextSpan(text:"${widget.userTestResultModel[index].score.toInt()}",
                  style: AppTextStyle.urbanistMedium.copyWith(color: Colors.green,fontSize: 12.sp),
                  children: [
                TextSpan(text:"/${widget.userTestResultModel[index].questionCount}",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 12.sp))
              ]),),
            ],),
          );
        })
      ],),),
    );

  }
}
