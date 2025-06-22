


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/profile/profile_screen.dart';
import 'package:quiz/Screen/tabbox/tab_box_screen.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/styles/app_text_style.dart';

import '../../../blocs/auth/auth_event.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/images/app_images.dart';
import '../../register_and_login/widget/my_text_from.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key, required this.firstName, required this.lastName});
  final String firstName;
  final String lastName;
  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  TextEditingController firstnameController=TextEditingController();
  TextEditingController lastnameController=TextEditingController();
  int a=-1;
  FocusNode focusNode1=FocusNode();
  FocusNode focusNode2=FocusNode();
  @override
  void initState() {
    firstnameController.text=widget.firstName;
    lastnameController.text=widget.lastName;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yangilash"),
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(children: [
          SizedBox(height: 30.h,),
          MyTextFromField(
            focusNode: focusNode1,
            controller: firstnameController,
            labelText: 'Ismingizni yozing',
            perefixIcon: AppImages.person,
            valueChanged: (String value) {
              setState(() {});
            },
            regExp: AppConstants.textRegExp,
            errorText: "Ushbu maydon to'ldirilishi shart",
          ),
          SizedBox(height: 20.h,),
          MyTextFromField(
            focusNode: focusNode2,
            controller:lastnameController,
            labelText: 'Familyangiznni  yozing',
            perefixIcon: AppImages.person,
            valueChanged: (String value) {
              setState(() {});
            },
            regExp: AppConstants.textRegExp,
            errorText: "Ushbu maydon to'ldirilishi shart",
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: TextButton(onPressed: ()async{
              focusNode1.unfocus();
              focusNode2.unfocus();
              a=1;
              setState(() {});
              if(firstnameController.text.isNotEmpty && lastnameController.text.isNotEmpty) {
                context.read<AuthBloc>().add(UpdateNameUserEvent(firstname:firstnameController.text,lastname: lastnameController.text));
                context.read<AuthBloc>().add(InfoUserEvent());
                await Future.delayed(Duration(seconds: 3));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ma'lumotlar o'zgartirildi",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.white),),backgroundColor:Colors.green,));
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                  return TabScreen();
                }));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ma'lumotlarni to'liring",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.white),),backgroundColor:Colors.red,));

              }

              },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.c257CFF,
                ),
                child:(a==1)?Center(child: CircularProgressIndicator(),):Text("Saqlash",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.white),)),
          ),
          SizedBox(height: 50.h,),
        ],),
      ),
    );
  }
}
