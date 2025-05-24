import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/home/home_screen.dart';
import 'package:quiz/Screen/register_and_login/onboarding/onboarding.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:flutter/material.dart';

import '../../tabbox/tab_box_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    debugPrint("BOSH:${StorageRepository.getString(key: 'key')}");
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StorageRepository.getString(key: 'key').isEmpty?OnboardingScreen():TabScreen() ,
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Image.asset(
          AppImages.splash,
          width: 350.w,
          height: 350.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
