import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/Question/Result/result_screen.dart';
import 'package:quiz/Screen/Question/StartQuestion/start_question_screen.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/coin_model/coin_model.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/extention/extantions.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../blocs/test/test_state.dart';
import '../../data/model/user_model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  int itemsPerPage = 4;
  int activeID = 0;

  List<String> category = [
    "Barchasi",
    "Saralash testlari 2023",
    "Tanqidiy fikrlash va muammoli masalalar",
    "English",
    "Barcha testlardan bepul na'munalar",
    "IQ testlar",
    "Tanqidiy fiklash 2024-2025",
    "Muammoli masalalar",
    "Asosiy imtihon uchun REPETITSION testlar",
    "Saralash testlari 2024",
  ];

  Widget buildPagination(int totalPages) {
    return SmartPagination(
      currentPage: currentPage,
      totalPages: totalPages,
      visibleRange: 1,
      onPageSelected: (page) {
        setState(() {
          currentPage = page;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text("Bosh sahifa", style: AppTextStyle.urbanistBold.copyWith(fontSize: 20.sp)),
          ),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state.formStatus == FormStatus.authenticated) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.sp),
                ),
                child: Row(children: [
                  (state.userInfoModel.photo.isEmpty)
                      ? Icon(Icons.account_circle_rounded, size: 34.sp)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network(
                      state.userInfoModel.photo,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${state.userInfoModel.firstName} ${state.userInfoModel.lastName}",
                          style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 20.sp)),
                      SizedBox(height: 5.h),
                    Row(children: [
                      Text("Balance: ${state.userInfoModel.checkBalance}",style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 12.sp),),
                      SizedBox(width: 10.w,),
                      Text("Rank: ${state.userInfoModel.rank}",style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 12.sp)),
                    ],)
                    ],
                  )
                ]),
              );
            } else if (state.formStatus == FormStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: Text(state.errorText));
          }),
          SizedBox(
            height:36.h,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              scrollDirection: Axis.horizontal,
              children: List.generate(category.length, (index) {
                return ZoomTapAnimation(
                  onTap: () {
                    activeID = index;
                    context.read<TestBloc>().add(TestAllEvent(subjectId: activeID));
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal:3.w),
                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(category[index],
                              style: AppTextStyle.urbanistBold.copyWith(fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // SizedBox(height: 16.h,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  BlocBuilder<TestBloc, TestState>(builder: (context, state2) {
                    if (state2.statusMessage == "test olindi") {
                      List<TestModel> allTests =state2.testModel;
                      int totalPages = (allTests.length / itemsPerPage).ceil();
                      List<TestModel> paginatedList = allTests
                          .skip((currentPage - 1) * itemsPerPage)
                          .take(itemsPerPage)
                          .toList();

                      return (state2.testModel.isNotEmpty)
                          ? SizedBox(
                        height: 500.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GridView.count(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                scrollDirection: Axis.horizontal,
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1.2,
                                children: List.generate(paginatedList.length, (index) {
                                  final test = paginatedList[index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: AppColors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        (test.image.isEmpty)
                                            ? Image.network(
                                          "https://pmtests.uz/static/media/logo.4498d5b43416f763567c.jpg",
                                          width: 100.w,
                                          height: 100.h,
                                        )
                                            : ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.r),
                                                topRight: Radius.circular(16.r)),
                                            child: Image.network(
                                              test.image,
                                              fit: BoxFit.cover,
                                              height: 100.h,
                                              width: double.infinity,
                                            )),
                                        SizedBox(height: 10.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(test.title,
                                                  style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 11.sp)),
                                              SizedBox(height: 5.h),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      if (test.discountPrice.isNotEmpty)
                                                        Text("${test.discountPrice} so'm",
                                                            style: AppTextStyle.urbanistRegular.copyWith(
                                                                overflow: TextOverflow.visible,
                                                                color: Colors.red,
                                                                fontSize: 10.sp,
                                                                decoration: TextDecoration.lineThrough,
                                                                decorationColor: Colors.red)),
                                                      Text("${test.price} so'm",
                                                          style: AppTextStyle.urbanistRegular.copyWith(
                                                              fontSize: 10.sp, color: AppColors.c257CFF)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Icon(Icons.watch_later_outlined, size: 10.sp),
                                                  SizedBox(width: 2.w),
                                                  Text("${test.duration} min",
                                                      style: AppTextStyle.urbanistRegular.copyWith(fontSize: 10.sp))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
                                          child: Row(
                                            children: [
                                              Text("${test.questionCount} ta savol"),
                                              Spacer(),
                                            (test.isFree)?((test.userTestModel.id!=0)?
                                            TextButton(onPressed:(){
                                              context.read<TestBloc>().add(ResultAllEvent(token: StorageRepository.getString(key: "access"),id:test.userTestModel.id!));
                                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                                                return ResultScreen();
                                              }));
                                              debugPrint("AAAAAA${test.userTestModel.id}");
                                            },
                                                style: TextButton.styleFrom(
                                                    backgroundColor: AppColors.c257CFF.withOpacity(0.2)),
                                                child:Text("Yechimni ko'rish", style: AppTextStyle.urbanistRegular.copyWith(
                                                    fontSize: 10.sp, color: AppColors.c257CFF))):
                                            TextButton(
                                                onPressed: () {
                                                  context.read<TestBloc>().add(QuestionAllEvent(token: StorageRepository.getString(key: "success"), id:test.id));
                                                  Navigator.push(context,MaterialPageRoute(builder: (context){
                                                    return QuestionScreen(subjectModel:test,);
                                                  }));
                                                },
                                                style: TextButton.styleFrom(
                                                    backgroundColor: AppColors.c257CFF.withOpacity(0.2)),
                                                child: Text("Testni Yechish",
                                                    style: AppTextStyle.urbanistRegular.copyWith(
                                                        fontSize: 10.sp, color: AppColors.c257CFF)),
                                              )):TextButton(onPressed: (){},
                                                style: TextButton.styleFrom(
                                                    backgroundColor: AppColors.c257CFF.withOpacity(0.2)),
                                                child:Text("Sotib olish",
                                                style: AppTextStyle.urbanistRegular.copyWith(
                                                    fontSize: 10.sp, color: AppColors.c257CFF)))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            buildPagination(totalPages),
                          ],
                        ),
                      )
                          : Center(child: Text("NO DATA"));
                    }
                    if(state2.formStatus == FormStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                        child: Text("EEEEEEE${state2.errorText} ${state2.testModel.length}"));
                  }),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmartPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageSelected;
  final int visibleRange;

  const SmartPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    this.visibleRange = 1,
    super.key,
  });

  List<Widget> buildPageItems() {
    List<Widget> items = [];

    void addPage(int page) {
      items.add(
        GestureDetector(
          onTap: () => onPageSelected(page),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: page == currentPage ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              '$page',
              style: TextStyle(
                color: page == currentPage ? Colors.white : Colors.blue,
                fontWeight: FontWeight.bold,fontSize: 16.sp
              ),
            ),
          ),
        ),
      );
    }

    void addDots() {
      items.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text('...'),
        ),
      );
    }

    addPage(1);

    if (currentPage - visibleRange > 2) {
      addDots();
    }

    for (int i = currentPage - visibleRange; i <= currentPage + visibleRange; i++) {
      if (i > 1 && i < totalPages) {
        addPage(i);
      }
    }

    if (currentPage + visibleRange < totalPages - 1) {
      addDots();
    }

    if (totalPages > 1) {
      addPage(totalPages);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildPageItems(),
      ),
    );
  }
}
