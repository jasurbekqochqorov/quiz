import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/styles/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Text("Profile",style: AppTextStyle.urbanistBold.copyWith(fontSize: 22.sp),),
            SizedBox(height: 20.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white
              ),
              child:Row(children: [
                Icon(Icons.account_circle_rounded,size: 34.sp,),
                SizedBox(width: 20.w,),
                Text(StorageRepository.getString(key: "name"),style: AppTextStyle.urbanistSemiBold.copyWith(fontSize: 20.sp),),
              Spacer(),
                Icon(Icons.edit),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
