import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Screen/chanel/chanel_screen.dart';
import 'package:quiz/Screen/home/home_screen.dart';
import 'package:quiz/Screen/users_rank/users_rank_screen.dart';
import 'package:quiz/utils/styles/app_text_style.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/test/test_bloc.dart';
import '../../blocs/test/test_event.dart';
import '../../utils/colors/app_colors.dart';
import '../profile/profile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int activeIndex=0;
  List<Widget> screens = [
    const HomeScreen(),
    const UsersRankScreen(),
    const ChanelScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    context.read<TestBloc>().add(TestAllEvent(subjectId: 0));
    context.read<AuthBloc>().add(InfoUserEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      backgroundColor: Colors.white70,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: activeIndex,
        onTap: (newIndex) {
          activeIndex=newIndex;
          setState(() {});
        },
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyle.urbanistRegular.copyWith(fontSize: 10.sp,color: AppColors.black),
        selectedItemColor:AppColors.c257CFF,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category,color: AppColors.black,size: 22.sp,),
            label: "Tests",
            activeIcon: Icon(
              Icons.category,color: AppColors.c257CFF,size: 22.sp,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made_sharp,color: AppColors.black,size: 22.sp),
            label: "Reyting",
            activeIcon: Icon(
              Icons.call_made_sharp,color: AppColors.c257CFF,size: 22.sp
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined,color: AppColors.black,size: 22.sp),
            label: "Kanallarimiz",
            activeIcon: Icon(
              Icons.supervised_user_circle_outlined,color: AppColors.c257CFF,size: 22.sp
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: AppColors.black,size: 22.sp),
            label: "Profile",
            activeIcon: Icon(
              Icons.person,color: AppColors.c257CFF,size: 22.sp
            ),
          )
        ],
      ),
    );
  }
}
