import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz/Screen/Question/Result/result_screen.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_state.dart';
import 'package:quiz/data/model/questionMain/question_main_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../blocs/test/test_event.dart';
import '../../data/local/local.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../Question/Result/widget/first_widget.dart';
import '../global_widget/appBar.dart';
import '../tabbox/tab_box_screen.dart';

class ResultMainScreen extends StatefulWidget {
  const ResultMainScreen({super.key,required this.questionMainModel});
  final QuestionMainModel questionMainModel;
  @override
  State<ResultMainScreen> createState() => _ResultMainScreenState();
}

class _ResultMainScreenState extends State<ResultMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<TestBloc,TestState>(builder: (context,state){
        if(state.formStatus==FormStatus.loading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state.formStatus==FormStatus.success && state.statusMessage=="Test natijalar yuborildi"){
          return Column(
            children: [
              GlobalAppBar(title:'Sizning Natijangiz',
                  onPressed:(){
                    context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                      return const TabScreen();
                    }));
                  }),
              SizedBox(height: 22.h,),
              Padding(padding:EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(children: [
                  FirstWidget(title:widget.questionMainModel.title,color:Colors.indigoAccent,),
                  SizedBox(height: 19.h,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.c257CFF,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(width: 1,color: AppColors.c257CFF)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                    child:Row(children: [
                      CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        startAngle: 0,
                        radius: 65.r,
                        lineWidth: 10.h,
                        percent:state.answer.score.toDouble()/state.answer.questionCount,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(text:TextSpan(
                                text: '${state.answer.score}',
                                style: AppTextStyle.urbanistMedium.copyWith(
                                    color:AppColors.c1D1E25,fontSize: 20.sp
                                ),
                                children: [
                                  TextSpan(
                                      text:'/${state.answer.questionCount}',
                                      style: AppTextStyle.urbanistRegular.copyWith(
                                          color: AppColors.c1D1E25,fontSize: 15.sp
                                      )
                                  )
                                ]
                            )),
                            Text('sizning balingiz',style: AppTextStyle.urbanistSemiBold.copyWith(
                                color: AppColors.c1D1E25.withOpacity(0.75),fontSize: 10.sp
                            ),)
                          ],),
                        animation: true,
                        animationDuration:1500,
                        progressColor:Colors.orange,
                        backgroundColor:Colors.orangeAccent.withOpacity(0.6),

                      ),
                      SizedBox(width: 15.w,),
                      Expanded(
                        child: Text('Tabriklaymiz\nSizning\nNatijangiz:${(state.answer.score*100/state.answer.questionCount).toStringAsFixed(0)}%',style: AppTextStyle.urbanistSemiBold.copyWith(
                          fontSize: 14.sp,color:AppColors.c1D1E25,
                        ),),
                      )
                    ],),
                  ),
                  SizedBox(height: 19.h,),
                  ZoomTapAnimation(
                      onTap: (){
                        context.read<TestBloc>().add(ResultAllEvent(token: StorageRepository.getString(key: "access"),id:widget.questionMainModel.id));
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                          return ResultScreen();
                        }));
                      },
                      child: FirstWidget(title:'Natijani tekshirish',color: AppColors.c257CFF,)),
                  SizedBox(height: 15.h,),
                ],),)
            ],
          );

        }
        return Center(child: Text("data"));
      }),
    );
  }
}
