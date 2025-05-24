import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import '../../blocs/test/test_state.dart';
import '../../data/model/user_model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TestBloc>().add(TestAllEvent(token:StorageRepository.getString(key: 'key')));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body:BlocBuilder<TestBloc,TestState>(builder: (context,state){
        if(state.statusMessage=="success"){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h,),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: Text("Bosh sahifa",style: AppTextStyle.urbanistBold.copyWith(fontSize: 20.sp),),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                decoration: BoxDecoration(
                    color: AppColors.white
                ),
                child:Row(children: [
                  Icon(Icons.account_circle_rounded,size: 34.sp,),
                  SizedBox(width: 20.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StorageRepository.getString(key: "name"),style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 20.sp),),
                      SizedBox(height: 5.h,),
                      Row(children: [
                        Text("Balans:0",style: AppTextStyle.urbanistBold.copyWith(fontSize: 14.sp)),
                        SizedBox(width: 10.w,),
                        Text("Hisob:0",style: AppTextStyle.urbanistBold.copyWith(fontSize: 14.sp),),
                      ],)
                    ],)
                ],),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: Text(state.subjectModel.message,style: AppTextStyle.urbanistBold,),
              ),
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:List.generate(10, (index){
                    return Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      decoration:BoxDecoration(
                        color: AppColors.c257CFF,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(state.subjectModel.tests[0].title),
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          );
        }
        else if(state.statusMessage=="error"){
          return Text("errpr");
        }
        return Center(child: CircularProgressIndicator(),);
      })
    );
  }
}
