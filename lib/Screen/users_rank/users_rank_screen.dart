import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/rank/rank_bloc.dart';
import 'package:quiz/blocs/rank/rank_state.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class UsersRankScreen extends StatefulWidget {
  const UsersRankScreen({super.key});

  @override
  State<UsersRankScreen> createState() => _UsersRankScreenState();
}

class _UsersRankScreenState extends State<UsersRankScreen> {
  int currentPage = 1;
  final int itemsPerPage = 9;

  Widget buildPagination(int totalItems) {
    int totalPages = (totalItems / itemsPerPage).ceil();
    List<int> pageList = [];

    if (totalPages <= 5) {
      pageList = List.generate(totalPages, (index) => index + 1);
    } else {
      if (currentPage <= 3) {
        pageList = [1, 2, 3, 4, 0, totalPages];
      } else if (currentPage >= totalPages - 2) {
        pageList = [1, 0, totalPages - 3, totalPages - 2, totalPages - 1, totalPages];
      } else {
        pageList = [1, 0, currentPage - 1, currentPage, currentPage + 1, 0, totalPages];
      }
    }

    return Center(
      child: SizedBox(
        height: 28.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: pageList.length,
          itemBuilder: (context, index) {
            final page = pageList[index];
            if (page == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Center(child: Text("...", style: AppTextStyle.urbanistRegular.copyWith(fontSize: 14.sp))),
              );
            } else {
              return ZoomTapAnimation(
                onTap: () {
                  setState(() {
                    currentPage = page;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: (currentPage == page) ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    "$page",
                    style: AppTextStyle.urbanistRegular.copyWith(
                      fontSize: 12.sp,
                      color: (currentPage == page) ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.call_made_sharp),
        title: Text("Foydalanuvchilar reytingi", style: AppTextStyle.urbanistRegular),
      ),
      body: BlocBuilder<RankBloc, RankState>(builder: (context, state) {
        if (state.formStatus == FormStatus.success && state.statusMessage == "Rating keldi") {
          final allUsers = state.userRatingModel;
          final totalPages = (allUsers.length / itemsPerPage).ceil();

          final paginatedUsers = allUsers
              .skip((currentPage - 1) * itemsPerPage)
              .take(itemsPerPage)
              .toList();

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(paginatedUsers.length, (index) {
                    final user = paginatedUsers[index];
                    final globalIndex = ((currentPage - 1) * itemsPerPage) + index;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        tileColor: Colors.white,
                        trailing: Text(
                          "${user.testsEfficiency.toInt()}%    ${user.testsRank}",
                          style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 11.sp),
                        ),
                        leading: Container(
                          width: 42.w,
                          height: 42.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (globalIndex == 0)
                                ? Colors.orange
                                : (globalIndex == 1)
                                ? Colors.deepOrange
                                : (globalIndex == 2)
                                ? Colors.grey
                                : Colors.grey.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text(
                              "${globalIndex + 1}",
                              style: AppTextStyle.urbanistSemiBold.copyWith(fontSize:(globalIndex>1000)?10.sp:14.sp),
                            ),
                          ),
                        ),
                        title: Text(
                          "${user.firstname} ${user.lastname}",
                          style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    );
                  }),
                   SizedBox(height: 16.h),
                  if (totalPages > 1) buildPagination(allUsers.length),
                ],
              ),
            ),
          );
        }

        if (state.formStatus == FormStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(child: Text("${state.userRatingModel.length}"));
      }),
    );
  }
}
