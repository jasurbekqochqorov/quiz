import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/Question/StartQuestion/widget/bottom_container.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_state.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import '../../../blocs/test/test_event.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../../utils/utility_functions.dart';
import '../Quiz/quiz_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.subjectModel});
  final TestModel subjectModel;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Test haqida ma'lumot",style: AppTextStyle.urbanistBold.copyWith(fontSize: 20.sp)),
      ),
      body:BlocBuilder<TestBloc,TestState>(builder:(context,state){
        if(state.statusMessage=="savollar olindi"){
          return Column(
            children: [
              SizedBox(height: 22.h),
              Expanded(
                child: Stack(
                  children: [
                    Container(width: double.infinity,
                        padding:
                        EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h,bottom: 100.h),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.r),
                                topRight: Radius.circular(40.r))),
                        child: SingleChildScrollView(
                          physics:const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(widget.subjectModel.image,width: 250.w,height:250.h,),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'Fan: ${widget.subjectModel.title}',
                                style: AppTextStyle.urbanistBold.copyWith(
                                    color: AppColors.black,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Savollar soni: ',
                                      style: AppTextStyle.urbanistMedium.copyWith(
                                          color: AppColors.black, fontSize: 16.sp),
                                      children: [
                                        TextSpan(
                                            text: ' ${state.questions.questions.length} ta',
                                            style: AppTextStyle.urbanistBold.copyWith(
                                                color: AppColors.black,
                                                fontSize: 16.sp))
                                      ])),
                              SizedBox(
                                height: 12.h,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Umumiy vaqt:',
                                      style: AppTextStyle.urbanistMedium.copyWith(
                                          color: AppColors.black, fontSize: 16.sp),
                                      children: [
                                        TextSpan(
                                            text: ' ${getMinutelyText(widget.subjectModel.questionCount*120)}',
                                            style: AppTextStyle.urbanistBold.copyWith(
                                                color: AppColors.black,
                                                fontSize: 16.sp))
                                      ])),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                'Yo\'riqnoma :',
                                style: AppTextStyle.urbanistBold.copyWith(
                                    color: AppColors.black, fontSize: 16.sp),
                              ),
                              SizedBox(height: 100.h,),
                            ],
                          ),
                        )),
                    BottomContainer(
                      k: widget.subjectModel.questionCount*120,
                      onTap: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                          return QuizScreen(questionModel: state.questions.questions,subjectModel:widget.subjectModel,);
                        }));
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },),
    );
  }
}
