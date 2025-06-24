import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Screen/home/home_screen.dart';
import 'package:quiz/Screen/users_rank/users_rank_screen.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (newIndex) {
          activeIndex=newIndex;
          setState(() {});
        },
        selectedItemColor:AppColors.c257CFF,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Tests",
            activeIcon: Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made_sharp),
            label: "Reyting",
            activeIcon: Icon(
              Icons.call_made_sharp,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            activeIcon: Icon(
              Icons.person,
            ),
          )
        ],
      ),
    );
  }
}
