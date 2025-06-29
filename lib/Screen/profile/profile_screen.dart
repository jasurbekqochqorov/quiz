import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/Screen/Question/Result/result_screen.dart';
import 'package:quiz/Screen/profile/balances/balance_history_screen.dart';
import 'package:quiz/Screen/profile/hisob/payment_screen.dart';
import 'package:quiz/Screen/profile/myTest/my_test_screen.dart';
import 'package:quiz/Screen/profile/updateName/update_screen.dart';
import 'package:quiz/blocs/auth/auth_bloc.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/data/local/local.dart';
import 'package:quiz/data/model/coin_model/coin_model.dart';
import 'package:quiz/utils/colors/app_colors.dart';
import 'package:quiz/utils/styles/app_text_style.dart';

import '../../blocs/auth/auth_state.dart';
import '../register_and_login/sign_in/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  CoinModel coinModel=CoinModel.initial();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:BlocBuilder<AuthBloc,AuthState>(builder: (context,state){
        if(state.formStatus==FormStatus.authenticated){
          return  Padding(
            padding: EdgeInsets.only(left: 20.w,top: 50.h,right: 20.w,bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profile",style: AppTextStyle.urbanistBold.copyWith(fontSize: 22.sp),),
                SizedBox(height: 20.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                  decoration: BoxDecoration(
                      color:Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16.r)
                  ),
                  child:Row(children: [
                    (state.userInfoModel.photo.isEmpty)?Icon(Icons.account_circle_rounded,size: 34.sp,):ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.network(state.userInfoModel.photo,width: 50.sp,height: 50.sp,fit: BoxFit.cover,),),
                    SizedBox(width: 20.w,),
                    Text("${state.userInfoModel.firstName} ${state.userInfoModel.lastName}",style: AppTextStyle.urbanistSemiBold,),
                    Spacer(),
                    IconButton(onPressed: (){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                        return UpdateNameScreen(firstName:state.userInfoModel.firstName, lastName:state.userInfoModel.lastName);
                      }));
                    }, icon: Icon(Icons.edit,size: 16.sp,)),
                  ],),
                ),
                SizedBox(height: 30.h,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          tileColor:Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          leading: Icon(Icons.person,size: 22.sp,),
                          splashColor: Colors.blue,
                          title: Text(state.userInfoModel.firstName,style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black.withOpacity(0.3)),),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          leading: Icon(Icons.person,size: 22.sp),
                          splashColor: Colors.blue,
                          title: Text(state.userInfoModel.lastName,style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black.withOpacity(0.3)),),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          leading: Icon(Icons.phone,size: 22.sp),
                          splashColor: Colors.blue,
                          title: Text("+${state.userInfoModel.phone}",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black.withOpacity(0.3)),),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          leading: Icon(Icons.key,size: 22.sp),
                          splashColor: Colors.blue,
                          title:Text(password(state.userInfoModel.passwordLength),style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black.withOpacity(0.3)),),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          leading: Icon(Icons.account_balance,size: 22.sp),
                          splashColor: Colors.blue,
                          title:Text("${state.userInfoModel.checkBalance} so'm",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black.withOpacity(0.3)),),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return PaymentScreen(userInfoModel: state.userInfoModel,);
                            }));
                          },
                          tileColor: Colors.blue.withOpacity(0.7),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          splashColor: Colors.white,
                          title:Text("Hisobni to'ldirish",style: AppTextStyle.urbanistSemiBold,),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor: Colors.blue.withOpacity(0.7),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          splashColor: Colors.white,
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return BalanceHistoryScreen(balance:state.userInfoModel.balances,);
                            }));
                          },
                          title: Text("Hisob tarixim",style: AppTextStyle.urbanistSemiBold,),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor: Colors.blue.withOpacity(0.7),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          splashColor: Colors.white,
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MyTestScreen(userTestResultModel:state.userInfoModel.userTest,);
                            }));
                          },
                          title: Text("Mening testlarim",style: AppTextStyle.urbanistSemiBold,),
                        ),
                        SizedBox(height: 10.h,),
                        ListTile(
                          tileColor:Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          leading: Icon(Icons.logout,color: Colors.red,size: 22.sp),
                          splashColor: Colors.blue.withOpacity(0.7),
                          onTap:() {
                            StorageRepository.setString(key: "access", value: "");
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return SignInScreen();
                            }));
                          },
                          title: Text("Log out",style: AppTextStyle.urbanistSemiBold.copyWith(color: Colors.red),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }),
    );
  }
   String password(int k){
    String a="";
    List.generate(k,(index){
      a="*$a";
    });
    return a;
  }
}


