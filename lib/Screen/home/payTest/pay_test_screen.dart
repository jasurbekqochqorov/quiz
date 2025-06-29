

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/tabbox/tab_box_screen.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/payment/payment_bloc.dart';
import 'package:quiz/blocs/payment/payment_event.dart';
import 'package:quiz/blocs/payment/payment_state.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import 'package:quiz/data/model/user_info/user_info_model.dart';
import 'package:quiz/utils/styles/app_text_style.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../blocs/test/test_event.dart';
import '../../../utils/colors/app_colors.dart';

class PayTestScreen extends StatefulWidget {
  const PayTestScreen({super.key,required this.testModel, required this.userInfoModel});

  final TestModel testModel;
  final UserInfoModel userInfoModel;
  @override
  State<PayTestScreen> createState() => _PayTestScreenState();
}

class _PayTestScreenState extends State<PayTestScreen> {
  bool pay=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<AuthBloc>().add(InfoUserEvent());
          context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return TabScreen();
          }));
        }, icon: Icon(Icons.arrow_back,size: 24.sp,)),
        title: Text("To'lov qismi",style: AppTextStyle.urbanistMedium.copyWith(fontSize: 18.sp),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${widget.testModel.title} uchun to'lovni amalga oshirish",style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 18.sp),textAlign: TextAlign.center,),
            SizedBox(height: 10.h,),
            Row(children: [
              Text("Tolov usuli:",style: AppTextStyle.urbanistRegular,),
              SizedBox(width: 10.w,),
              Image.network("https://uzoplata.com/wp-content/uploads/2021/12/click.png",width: 80.w,height: 80.h,fit: BoxFit.cover,),
            ],),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Sizning hisobingiz",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 12.sp),),
              SizedBox(height: 4.h,),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                leading: Icon(Icons.account_balance,size: 22.sp),
                splashColor: Colors.blue,
                title:Text("${widget.userInfoModel.checkBalance} so'm",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black),),
              ),
            ],),
            SizedBox(height: 16.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Test uchun yechib olinadigan summa",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 12.sp),),
              SizedBox(height: 4.h,),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                leading: Icon(Icons.account_balance,size: 22.sp),
                splashColor: Colors.blue,
                title:Text("-${widget.testModel.price} so'm",style: AppTextStyle.urbanistSemiBold.copyWith(color: Colors.red),),
              ),
            ],),
            SizedBox(height: 16.h,),
            SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: (){
                  context.read<PaymentBloc>().add(PayPaymentEvent(id: widget.testModel.id));
                pay=true;
                setState(() {});
                  },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.c257CFF
                    ),
                    child: (pay)?Center(child: CircularProgressIndicator(),):Text("Sotib olish",style: AppTextStyle.urbanistRegular.copyWith(color: AppColors.white),))),
            BlocConsumer<PaymentBloc,PaymentState>(builder: (context,state){
              return Text(state.statusMessage);
            },
                listener:(BuildContext context,PaymentState state){
              if(state.statusMessage=="To'landi" && state.formStatus==FormStatus.pure){
                pay=false;
                setState(() {});
                context.read<AuthBloc>().add(InfoUserEvent());
                context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return TabScreen();
                }));
                setState(() {});
              }
                })
          ],
        ),
      ),
    );
  }
}
