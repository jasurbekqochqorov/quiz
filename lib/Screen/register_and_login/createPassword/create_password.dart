import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/home/home_screen.dart';
import 'package:quiz/Screen/register_and_login/sign_in/sign_in_screen.dart';
import 'package:quiz/Screen/tabbox/tab_box_screen.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/user_model/user_model.dart';
import 'package:quiz/utils/extention/extantions.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../blocs/auth/auth_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/images/app_images.dart';
import '../sign_up/widget/check.dart';
import '../widget/my_text_from.dart';


class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key, required this.userModel,required this.isForget});
  final bool isForget;
  final UserModel userModel;
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController password1Controller=TextEditingController();
  TextEditingController password2Controller=TextEditingController();
  bool obthorText=true;
  bool obthorText2=true;
  bool check = false;
  bool write = false;
  bool minimumEightcharacters = false;
  bool atleastNumber = false;
  bool atleastLowercaseOrUppercaseLetters = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parol Yaratish"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(builder: (context,state){
        return Padding(
          padding:EdgeInsets.symmetric(horizontal: 24.w,vertical: 30.h),
          child: Column(children: [
            MyTextFromField(
              controller: password1Controller,
              textInputAction: TextInputAction.done,
              onTab: () {
                setState(() {
                  obthorText = !obthorText;
                });
              },
              labelText: 'Parol kiriting',
              perefixIcon: AppImages.lock,
              obzorText: obthorText,
              suffixIcon:
              !obthorText ? AppImages.openEye : AppImages.closeEye,
              valueChanged: _onChange,
              regExp: AppConstants.passwordRegExp,
              errorText: 'Parol yaroqli emas',
            ),
            SizedBox(height: 20.h,),
            MyTextFromField(
              controller: password2Controller,
              textInputAction: TextInputAction.done,
              onTab: () {
                setState(() {
                  obthorText2 = !obthorText2;
                });
              },
              labelText: 'Parolingizni tasdiqlang',
              perefixIcon: AppImages.lock,
              obzorText: obthorText2,
              suffixIcon:
              !obthorText2 ? AppImages.openEye : AppImages.closeEye,
              valueChanged: _onChange,
              regExp: AppConstants.passwordRegExp,
              errorText: 'Parollar mos emas',
            ),
            SizedBox(height: 16.h,),
            if (write)
              CheckInput(
                  check: minimumEightcharacters,
                  title: "Minimum 8 ta belgi bo'lsin"),
            if (write)
              CheckInput(
                  check: atleastNumber, title: "Raqamlar ham bo'lsin"),
            if (write)
              CheckInput(
                  check: atleastLowercaseOrUppercaseLetters,
                  title: "Katta yoki kichik harflar ham qatnashsin"),

            SizedBox(height: 20.h,),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){
                UserModel userModel=widget.userModel;
                if(password2Controller.text.isNotEmpty && password1Controller.text.isNotEmpty){
                  if(password1Controller.text!=password2Controller.text){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Parollar mos emas",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }
                  else {
                    userModel=userModel.copyWith(
                        password:password1Controller.text,
                        showPassword: password2Controller.text
                    );
                    debugPrint("Aadfs${widget.isForget}");
                    (widget.isForget)?context.read<AuthBloc>().add(AuthUpdatePasswordEvent(newPassword:password2Controller.text,phone: widget.userModel.phone)):
                context.read<AuthBloc>().add(
                      RegisterUserEvent(userModel: userModel),
                    );
                  }
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "Yuqoridagi ma'lumotlarni to'ldiring",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }
              },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.c257CFF,
                  ),
                  child:Text("TASDIQLASH",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.white),)),
            )
          ],),
        );
      }, listener:(BuildContext context, AuthState state) {
        if (state.statusMessage == "this_number_already_registered") {}
        if (state.statusMessage == "registered"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabScreen()
            ),
          );
        }
        if(state.statusMessage=="Updated"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return SignInScreen();
          }));
        }
      }
    ),
    );
  }
  _onChange(String value) {
    write = true;
    if (value.length > 7) {
      minimumEightcharacters = true;
    }
    if (value.length < 7) {
      minimumEightcharacters = false;
    }
    if (value.isDigitMy()) {
      atleastNumber = true;
    }
    if (!value.isDigitMy()) {
      atleastNumber = false;
    }
    if (value.isAlphaMy()) {
      atleastLowercaseOrUppercaseLetters = true;
    }
    if (!value.isAlphaMy()) {
      atleastLowercaseOrUppercaseLetters = false;
    }
    setState(() {});
  }
}

