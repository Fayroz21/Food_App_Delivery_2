import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/components/Custom_backGround2.dart';
import 'package:food_delivery_app/components/Custom_button.dart';
import 'package:food_delivery_app/screens/Login_screen/Login_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../Constants/consts.dart';
import '../../components/Custom_Text.dart';
import '../../constants/otherConsts/other_consts.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      CustomBackGround2(
        image: 'assets/images/Pattern.png',
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset('assets/images/check.png'),
                  K.fixed10h,
                  K.fixed10h,
                  CustomText(
                    text: 'Congrats!',
                    size: 25.sp,
                    color: Const.mainColor,
                  ),
                  K.fixed10h,
                  CustomText(
                    text: 'Your Profile Is Ready To Use',
                    size: 22.sp,
                  ),
                ],
              ),
            ),
            K.fixed10h,
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 40).w,
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    text: 'Try Order',
                  ),
                ))
          ],
        )));

  }
}

