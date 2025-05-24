import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Screen/home/home_screen.dart';

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
    const ProfileScreen(),
  ];


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
            label: "Categories",
            activeIcon: Icon(
              Icons.category,
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
