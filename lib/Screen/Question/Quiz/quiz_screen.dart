import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/Question/Quiz/widget/button_down.dart';
import 'package:quiz/Screen/Question/Quiz/widget/information.dart';
import 'package:quiz/Screen/Question/Quiz/widget/questions_button.dart';
import 'package:quiz/Screen/tabbox/tab_box_screen.dart';
import 'package:quiz/data/model/Question/question_model.dart';
import 'package:quiz/data/model/questionMain/question_main_model.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import '../../../blocs/test/test_bloc.dart';
import '../../../blocs/test/test_event.dart';
import '../../../data/local/local.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/extention/extantions.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../../utils/utility_functions.dart';
import '../../RusltMain/result_main_screen.dart';
import '../../global_widget/appBar.dart';
import '../Result/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.questionModel, required this.subjectModel});

  final TestModel subjectModel;
  final QuestionMainModel questionModel;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int count = 0;
  int activeIndex = 0;
  int activeVariant = 0;
  int activeAnswer=-1;
  Map<int, int> selectedAnswer = {};
  List<Map<String,dynamic>> selectTo = [];
  bool _isMounted = true;
  String answer1="";

  Future<void> _timerLogic() async {
    for (int i = widget.questionModel.deadline; i > 0; i--) {
      if (!_isMounted) break;
      if (mounted) {
        setState(() {
          count = i;
        });
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    if (_isMounted){
      for(int i=0;i<selectedAnswer.length; i++){
        answer1="";
        if(selectedAnswer[i]==1){
          answer1="a";
        }
        else if(selectedAnswer[i]==2){
          answer1="b";
        }
        else if(selectedAnswer[i]==3){
          answer1="c";
        }
        else if(selectedAnswer[i]==4){
          answer1="d";
        }
        if(answer1.isNotEmpty){
          Map<String,dynamic> ans={
            "user_test":widget.questionModel.id,
            "question":i+1,
            "user_answer":"$answer1"
          };
          selectTo.add(ans);
        }
      }
      context.read<TestBloc>().add(PostResultAllEvent(answers:selectTo, id:widget.questionModel.id));
      _navigateToResultScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.questionModel.questions.length; i++) {
      selectedAnswer[i]=0;
    }
    _timerLogic();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: (widget.questionModel.questions.isNotEmpty)
            ? Column(
          children: [
            GlobalAppBar(
              title: "Testlar",
              isButton:true,
              onTap: () async{
                selectedAnswer[activeIndex] = activeVariant;
                for(int i=0;i<selectedAnswer.length; i++){
                  answer1="";
                  if(selectedAnswer[i]==1){
                    answer1="a";
                  }
                  else if(selectedAnswer[i]==2){
                    answer1="b";
                  }
                  else if(selectedAnswer[i]==3){
                    answer1="c";
                  }
                  else if(selectedAnswer[i]==4){
                    answer1="d";
                  }
                  if(answer1.isNotEmpty){
                    Map<String,dynamic> ans={
                      "user_test":widget.questionModel.id,
                      "question":i+1,
                      "user_answer":"$answer1"
                    };
                    selectTo.add(ans);
                  }
                }
                debugPrint("$selectTo");
                await Future.delayed(Duration(seconds: 5));
                context.read<TestBloc>().add(PostResultAllEvent(answers:selectTo, id:widget.questionModel.id));
                _navigateToResultScreen();
              },
              onPressed: () {
                context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return TabScreen();
                }));
              },
            ),
            SizedBox(height: 32.h),
            Information(
              subjectModel: widget.subjectModel,
              title: getMinutelyText(count),
              progressValue: count / (widget.subjectModel.questionCount * 120),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 32.w, right: 32.w, top: 10.h, bottom: 20.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(width: 2.sp, color: AppColors.c257CFF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.r),
                      topLeft: Radius.circular(40.r),
                    )),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Savol:${activeIndex + 1}/${widget.questionModel.questions.length}",
                                style: AppTextStyle.urbanistMedium.copyWith(
                                    color: AppColors.black, fontSize: 20.sp),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                decodeHtml(parseHtml(widget.questionModel.questions[activeIndex].text)),
                                style: AppTextStyle.urbanistSemiBold.copyWith(
                                  color: AppColors.black,
                                  fontSize: 17.sp,
                                ),
                              ),
                              if(widget.questionModel.questions[activeIndex].image.isNotEmpty)Image.network(widget.questionModel.questions[activeIndex].image),
                              SizedBox(height: 14.h),
                              QuestionsButton(
                                  onTap: () {
                                    activeVariant = 1;
                                    setState(() {});
                                  },
                                  isActive: activeVariant == 1,
                                  questionVariant: "A. ",
                                  variant:decodeHtml(parseHtml(widget.questionModel.questions[activeIndex].a))),
                              QuestionsButton(
                                  onTap: () {
                                    activeVariant = 2;
                                    setState(() {});
                                  },
                                  isActive: activeVariant == 2,
                                  questionVariant: "B. ",
                                  variant:decodeHtml(parseHtml(widget.questionModel.questions[activeIndex].b))),
                              QuestionsButton(
                                  onTap: () {
                                    activeVariant = 3;
                                    setState(() {});
                                  },
                                  isActive: activeVariant == 3,
                                  questionVariant: "C. ",
                                  variant: decodeHtml(parseHtml(widget.questionModel.questions[activeIndex].c))),
                              QuestionsButton(
                                  onTap: () {
                                    activeVariant = 4;
                                    setState(() {});
                                  },
                                  isActive: activeVariant == 4,
                                  questionVariant: "D. ",
                                  variant: decodeHtml(parseHtml(widget.questionModel.questions[activeIndex].d))),
                            ],
                          )
                        ],
                      ),
                    ),
                    ButtonDown(
                      onPrevious: () {
                        activeIndex--;
                        activeVariant = selectedAnswer[activeIndex]!;
                        setState(() {});
                        debugPrint("ASD--${selectedAnswer}");
                      },
                      onNext: () {
                        selectedAnswer[activeIndex] = activeVariant;
                        activeIndex++;
                        activeVariant = selectedAnswer[activeIndex]!;
                        debugPrint("ASD++${selectedAnswer}");
                        setState(() {});
                      },
                      questionModel: widget.questionModel.questions,
                      activeIndex: activeIndex,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : Center(child: Text("Testlar hali mavjud emas")),
      ),
    );
  }

  void _navigateToResultScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ResultMainScreen(questionMainModel: widget.questionModel,);
    }));
  }
}
