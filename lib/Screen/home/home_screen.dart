import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz/Screen/Question/Result/result_screen.dart';
import 'package:quiz/Screen/Question/StartQuestion/start_question_screen.dart';
import 'package:quiz/Screen/home/payTest/pay_test_screen.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../blocs/test/test_state.dart';

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
    "Muammoli masalalar",
    "Asosiy imtihon uchun REPETITSION testlar",
    "Tanqidiy fiklash 2024-2025",
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
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc,AuthState>(builder:(context,state){
        if (state.formStatus == FormStatus.authenticated){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text("Bosh sahifa", style: AppTextStyle.urbanistBold.copyWith(fontSize: 18.sp)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      spreadRadius: 0,
                      color: AppColors.black.withOpacity(0.4),
                      offset: Offset(0,4)
                    )
                  ],
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.sp),
                ),
                child: Row(children: [
                  (state.userInfoModel.photo.isEmpty)
                      ? Icon(Icons.account_circle_rounded, size: 34.sp)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(400.r),
                    child: Image.network(
                      state.userInfoModel.photo,
                      width: 50.sp,
                      height: 50.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("${state.userInfoModel.firstName} ${state.userInfoModel.lastName}",
                              style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 18.sp)),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(children: [
                        Text("Balance: ${state.userInfoModel.checkBalance}",style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 12.sp),),
                        SizedBox(width: 10.w,),
                        Text("Rank: ${state.userInfoModel.rank}",style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 12.sp)),
                      ],)
                    ],
                  )
                ]),
              ),
              SizedBox(height: 7.h),
              SizedBox(
                height:45.h,
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

                        margin: EdgeInsets.symmetric(horizontal:3.w,vertical: 5.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 0,
                                color: AppColors.black.withOpacity(0.4),
                                offset: Offset(0,2)
                            )
                          ],
                          color: (activeID==index)?AppColors.c257CFF:AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(category[index],
                              style: AppTextStyle.urbanistBold.copyWith(fontSize: 12.sp,color:(activeID==index)?AppColors.white:AppColors.black)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 5.h,),
              BlocBuilder<TestBloc, TestState>(builder: (context, state2) {
                if (state2.statusMessage == "test olindi") {
                  List<TestModel> allTests =state2.testModel;
                  int totalPages = (allTests.length / itemsPerPage).ceil();
                  List<TestModel> paginatedList = allTests
                      .skip((currentPage - 1) * itemsPerPage)
                      .take(itemsPerPage)
                      .toList();

                  return (state2.testModel.isNotEmpty)
                      ? Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16.w,),
                            // scrollDirection: Axis,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            childAspectRatio: 0.70,
                            children:[
                              ...List.generate(paginatedList.length, (index) {
                                final test = paginatedList[index];
                                return Container(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 6,
                                          spreadRadius: 0,
                                          color: AppColors.black.withOpacity(0.4),
                                          offset: Offset(0,4)
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: AppColors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      (test.image.isEmpty)
                                          ? Image.network("https://pmtests.uz/static/media/logo.4498d5b43416f763567c.jpg", width: 80.w, height: 80.h,)
                                          : ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.r),
                                              topRight: Radius.circular(16.r)),
                                          child: Image.network(
                                            test.image,
                                            fit: BoxFit.cover,
                                            height: 80.h,
                                            width: double.infinity,
                                          )),
                                      SizedBox(height: 10.h),
                                      Padding(padding: EdgeInsets.symmetric(horizontal: 16.w), child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(test.title,
                                              style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 10.sp)),
                                          SizedBox(height: 5.h),
                                          Row(
                                            children: [
                                              (test.isFree)?Text("Bepul",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 10.sp,color: AppColors.c257CFF),):(test.userTestModel.id!=0)?Text("Sotib olingan",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 10.sp,color: AppColors.c257CFF),):Column(
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
                                        padding: EdgeInsets.only(left: 16.w,right: 7.w,bottom: 4.h),
                                        child: Row(
                                          children: [
                                            Text("${test.questionCount} ta savol",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 9.sp),),
                                            Spacer(),
                                            (test.userTestModel.isSolid || test.isFree)?((test.userTestModel.isSolution)?
                                            ZoomTapAnimation(
                                                onTap: (){
                                                  context.read<TestBloc>().add(ResultAllEvent(token: StorageRepository.getString(key: "access"),id:test.userTestModel.id!));
                                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                                                    return ResultScreen();
                                                  }));
                                                },
                                                child: Container(
                                                  // margin: EdgeInsets.only(right: 7.w,bottom: 6.h),
                                                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 5.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.c257CFF.withOpacity(0.2)
                                                  ),
                                                  child: Text("Yechimni ko'rish",style: AppTextStyle.urbanistRegular.copyWith(
                                                      fontSize: 10.sp, color: AppColors.c257CFF),),
                                                )):
                                            ZoomTapAnimation(
                                                onTap: (){
                                                  context.read<TestBloc>().add(QuestionAllEvent(token: StorageRepository.getString(key: "success"), id:((test.userTestModel.isSolid)?test.userTestModel.id!:test.id),isSold:test.userTestModel.isSolid));
                                                  Navigator.push(context,MaterialPageRoute(builder: (context){
                                                    return QuestionScreen(subjectModel:test,);
                                                  }));
                                                },
                                                child: Container(
                                                  // margin: EdgeInsets.only(right: 7.w,bottom: 6.h),
                                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.c257CFF.withOpacity(0.2)
                                                  ),
                                                  child: Text("Testni Yechish",style: AppTextStyle.urbanistRegular.copyWith(
                                                      fontSize: 10.sp, color: AppColors.c257CFF),),
                                                ))):
                                            ZoomTapAnimation(
                                                onTap: (){
                                                  if(double.parse(test.price)>state.userInfoModel.checkBalance){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mablag' yetarli emas",style: AppTextStyle.urbanistRegular.copyWith(color: AppColors.white),),backgroundColor: Colors.red,),);
                                                  }
                                                  else{
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                      return PayTestScreen(testModel: test,userInfoModel: state.userInfoModel,);
                                                    }));
                                                  }
                                                },
                                                child: Container(
                                                  // margin: EdgeInsets.only(right: 7.w,bottom: 6.h),
                                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.c257CFF.withOpacity(0.2)
                                                  ),
                                                  child: Text("Sotib olish",style: AppTextStyle.urbanistRegular.copyWith(
                                                      fontSize: 10.sp, color: AppColors.c257CFF),),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],),
                          SizedBox(height: 10.h),
                          buildPagination(totalPages),
                          SizedBox(height: 50.h,)
                        ],
                      ),
                    ),
                  )
                      : Center(child: Text("NO DATA"));
                }
                if(state2.formStatus == FormStatus.loading) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                        ),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        topRight: Radius.circular(16.r),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 14.h,
                                          width: double.infinity,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 5.h),
                                        Container(
                                          height: 10.h,
                                          width: 60.w,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10.h,
                                          width: 50.w,
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 30.h,
                                          width: 60.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return Center(
                    child:LottieBuilder.asset(AppImages.empty));
              }),
              // SizedBox(height: 50.h),
            ],
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 120.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
          
              // Profile container shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 70.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.sp),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50.sp,
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(400.r),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w,
                              height: 16.h,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 12.h,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  width: 30.w,
                                  height: 12.h,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
          
              // Category tabs shimmer
              SizedBox(
                height: 38.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Row(
                      children: List.generate(3, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: 80.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Tests grid shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 14.h,
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    height: 10.h,
                                    width: 60.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                children: [
                                  Container(
                                    height: 10.h,
                                    width: 50.w,
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        );

      }),
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
