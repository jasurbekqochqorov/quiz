import 'package:quiz/Screen/home/widgets/doctor_items.dart';
import 'package:quiz/Screen/home/widgets/doctor_logo.dart';
import 'package:quiz/Screen/home/widgets/ring_and_favorite_items.dart';
import 'package:quiz/Screen/home/widgets/see_all_items.dart';
import 'package:quiz/Screen/home/widgets/specialist_items.dart';
import 'package:quiz/Screen/home/widgets/textfield_items.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/images/app_images.dart';
import 'package:quiz/utils/size/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            68.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const DoctorLogo(),
                      20.getW(),
                      Text(
                        "DoctorQ",
                        style: TextStyle(
                          color: AppColors.c_2C3A4B,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      RingAndFavoriteItems(
                        icon: AppImages.lock,
                        onTap: () {},
                      ),
                      16.getW(),
                      RingAndFavoriteItems(
                        icon: AppImages.lock,
                        onTap: () {},
                      ),
                    ],
                  ),
                  26.getH(),
                  const TextFieldItems(),
                  24.getH(),
                  Row(
                    children: [
                      Text(
                        "Specialist Doctor",
                        style: TextStyle(
                          color: AppColors.c_2C3A4B,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      SeeAllItems(
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            24.getH(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  24.getW(),
                  SpecialistItems(
                    icon: AppImages.favorite,
                    title: "Cardio Specialist",
                    subTitle: "252 Doctors",
                    color1: AppColors.c_FF1843,
                    color2: AppColors.c_FF5E7C,
                    onTap: () {},
                  ),
                  SpecialistItems(
                    icon: AppImages.favorite,
                    title: "Dental Specialist",
                    subTitle: "186 Doctors",
                    color1: AppColors.c_2972FE,
                    color2: AppColors.c_6499FF,
                    onTap: () {},
                  ),
                  SpecialistItems(
                    icon: AppImages.favorite,
                    title: "Eye Specialist",
                    subTitle: "201 Doctors",
                    color1: AppColors.c_FFB800,
                    color2: AppColors.c_FFDA7B,
                    onTap: () {},
                  ),
                  8.getW(),
                ],
              ),
            ),
            24.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    "Top Doctor",
                    style: TextStyle(
                      color: AppColors.c_2C3A4B,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  SeeAllItems(
                    onTap: () {},
                  ),
                ],
              ),
            ),
            24.getH(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  24.getW(),
                  DoctorItems(
                    image: AppImages.doctor,
                    title: "Dr. Jerome Bell",
                    subtitle: "Cardio Specialist",
                    onTap: () {},
                  ),
                  DoctorItems(
                    image: AppImages.doctor,
                    title: "Dr. Jenny Wilson",
                    subtitle: "Dental Specialist",
                    onTap: () {},
                  ),
                  DoctorItems(
                    image: AppImages.doctor,
                    title: "Dr. Dianne Russell",
                    subtitle: "Eye Specialist",
                    onTap: () {},
                  ),
                  8.getW(),
                ],
              ),
            ),
            24.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    "Recommendation",
                    style: TextStyle(
                      color: AppColors.c_2C3A4B,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  SeeAllItems(
                    onTap: () {},
                  ),
                ],
              ),
            ),
            24.getH(),
          ],
        ),
      ),
    );
  }
}
