
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/payment/payment_bloc.dart';
import 'package:quiz/blocs/payment/payment_event.dart';
import 'package:quiz/blocs/payment/payment_state.dart';
import 'package:quiz/data/model/user_info/user_info_model.dart';
import 'package:quiz/utils/styles/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key,required this.userInfoModel});

  final UserInfoModel userInfoModel;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool go=false;
  final TextEditingController _controller = TextEditingController();
  final NumberFormat _formatter = NumberFormat("#,###", "en_US");
  FocusNode focusNode=FocusNode();
  void _onChanged(String value) {
    if(_controller.text.length>=7){
      focusNode.unfocus();
      setState(() {});
    }
    String text = value.replaceAll(",", "");
    if (text.isEmpty) return;

    final number = int.tryParse(text);
    if (number == null) return;

    final newText = _formatter.format(number);

    if (newText != _controller.text) {
      final selectionIndex = newText.length;
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hisobni to'ldirish",style: AppTextStyle.urbanistMedium,),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("To'lov usuli:",style: AppTextStyle.urbanistMedium,),
                SizedBox(width: 10.w,),
                Image.network("https://uzoplata.com/wp-content/uploads/2021/12/click.png",width: 80.w,height: 80.h,fit: BoxFit.cover,),
              ],
            ),
            Text("Sizning hisobingiz",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 12.sp),),
            SizedBox(height: 4.h,),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
              leading: Icon(Icons.account_balance,size: 22.sp),
              splashColor: Colors.blue,
              title:Text("${widget.userInfoModel.checkBalance} so'm",style: AppTextStyle.urbanistSemiBold.copyWith(color: AppColors.black.withOpacity(0.3)),),
            ),
            SizedBox(height: 16.h,),
            Text("Summani kiriting",style: AppTextStyle.urbanistRegular.copyWith(fontSize: 12.sp),),
            SizedBox(height: 8.h,),
            TextFormField(
              maxLength: 7,
              onChanged: _onChanged,
              focusNode: focusNode,
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_balance),
              label:Text("Summani kiriting"),
              suffixText: "So'm",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(width: 1.sp,color: AppColors.c257CFF)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.sp,color: AppColors.c257CFF),
                borderRadius: BorderRadius.circular(16.r)
              )
            ),
          ),
            SizedBox(height: 16.h,),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){
                debugPrint("AA${int.parse(_controller.text.replaceAll(",",""))}");
                context.read<PaymentBloc>().add(PostPaymentEvent(summa:int.parse(_controller.text.replaceAll(",",""))));
                go=true;
                setState(() {});
              },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.c257CFF
                  ),
                  child: (go)?Center(child: CircularProgressIndicator(),):Text("To'lovni amalga oshirish",style: AppTextStyle.urbanistMedium.copyWith(color: AppColors.white),)),
            ),
            BlocConsumer<PaymentBloc,PaymentState>(builder: (context,state){
              return Center(child: Text(""),);
            }, listener:(BuildContext context,PaymentState state){
              if(state.formStatus==FormStatus.success){
                debugPrint("AAAAAAAAAAAAAAAAAA2${state.statusMessage}");
                _launchURL(url: state.statusMessage);
              }
            })
          ],
        ),
      ),
    );
  }
  Future<void> _launchURL({required String url}) async {
    final Uri uri = Uri.parse("$url");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'URL ochib bo‘lmadi: $url';
    }
  }
  @override
  void dispose() {
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
