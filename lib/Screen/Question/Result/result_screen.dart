import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz/Screen/Question/Result/widget/first_widget.dart';
import 'package:quiz/Screen/Question/Result/widget/questions.dart';
import 'package:quiz/Screen/Question/Result/widget/true_and_wrong_answer.dart';
import 'package:quiz/Screen/home/home_screen.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/blocs/test/test_state.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/result/result_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/extention/extantions.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../global_widget/appBar.dart';
import '../../tabbox/tab_box_screen.dart';


class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key,});
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>{
  Map<String,dynamic> coin={};
  int trueAnswer=0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor:Colors.transparent,
      ),
      child: Scaffold(
        body:BlocBuilder<TestBloc,TestState>(builder: (context,state){
          if(state.statusMessage=="Natijalar olindi"){
            return Column(
              children: [
                GlobalAppBar(title:'Sizning Natijangiz',
                    onPressed:(){
                  context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
                      Navigator.pop(context);
                    }),
                SizedBox(height: 22.h,),
                Padding(padding:EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(children: [
                    FirstWidget(title:state.resultMainModel.title,color:AppColors.c257CFF,),
                    SizedBox(height:20.h,),
                    SizedBox(
                      height:500.h,
                      child: ListView(children: [
                        const TrueAndWrong(color:Colors.green,title: "Siz belgilagan to'g'ri javoblar",),
                        const TrueAndWrong(color:Colors.red,title: "Siz belgilagan noto'g'ri javoblar",),
                        const TrueAndWrong(color: Colors.blue,title:"Siz topa olmagan to'g'ri javoblar",),
                        SizedBox(height: 10.h,),
                        SizedBox(height:10.h,),
                        Column(children: [
                          ...List.generate(state.resultMainModel.question.length, (index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Savol: ${index+1}/${state.resultMainModel.question.length}",style: AppTextStyle.urbanistSemiBold.copyWith(
                                    color: AppColors.black,fontSize: 20.sp
                                ),),
                                SizedBox(height: 12.h,),
                                Text(decodeHtml(parseHtml(state.resultMainModel.question[index].text)),
                                  style: AppTextStyle.urbanistSemiBold.copyWith(
                                    color: AppColors.black,fontSize: 17.sp,
                                  ),),
                                SizedBox(height: 14.h,),
                                if(state.resultMainModel.question[index].image.isNotEmpty)Image.network(state.resultMainModel.question[index].image),
                                SizedBox(height: 8.h,),
                                Text("YECHIM: ${decodeHtml(parseHtml(state.resultMainModel.question[index].solution))}",style: AppTextStyle.urbanistMedium,),
                                if(state.resultMainModel.question[index].solutionImage.isNotEmpty)Image.network(state.resultMainModel.question[index].solutionImage),
                                Questions(
                                  isTrue2: "a"==state.resultMainModel.question[index].answer,
                                  isActive: (state.resultMainModel.question[index].userAnswer=="a"),
                                  questionVariant:"A. ",
                                  variant:parseHtml(state.resultMainModel.question[index].a),
                                  isTrue:(state.resultMainModel.question[index].userAnswer=="a" && state.resultMainModel.question[index].answer=="a"),
                                ),
                                Questions(
                                  isTrue2: "b"==state.resultMainModel.question[index].answer,
                                  isActive: (state.resultMainModel.question[index].userAnswer=="b"),
                                  questionVariant:"B. ",
                                  variant:parseHtml(state.resultMainModel.question[index].b),
                                  isTrue:(state.resultMainModel.question[index].userAnswer=="b" && "b"==state.resultMainModel.question[index].answer),
                                ),
                                Questions(
                                  isTrue2: "c"==state.resultMainModel.question[index].answer,
                                  isActive: (state.resultMainModel.question[index].userAnswer=="c"),
                                  questionVariant:"C. ",
                                  variant:parseHtml(state.resultMainModel.question[index].c),
                                  isTrue:(state.resultMainModel.question[index].userAnswer=="c" && "c"==state.resultMainModel.question[index].answer),
                                ),
                                Questions(
                                  isTrue2: "d"==state.resultMainModel.question[index].answer,
                                  isActive: (state.resultMainModel.question[index].userAnswer=="d"),
                                  questionVariant:"D. ",
                                  variant:parseHtml(state.resultMainModel.question[index].d),
                                  isTrue:(state.resultMainModel.question[index].userAnswer=="d" && "d"==state.resultMainModel.question[index].answer),
                                ),
                              ],);
                          })
                        ],),
                      ],),
                    ),
                  ],),),
              ],
            );
          }
          else if(state.formStatus==FormStatus.loading){
            return Center(child: CircularProgressIndicator(),);
          }
          return Center(child: Text("Internet yaxshi emas yoki${state.resultMainModel.title}"),);
        }),
      ),
    );
  }
}
