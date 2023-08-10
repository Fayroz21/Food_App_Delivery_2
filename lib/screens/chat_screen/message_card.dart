import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/components/Custom_Text.dart';
import 'package:food_delivery_app/shared_preference/shared_pref.dart';

import '../../Constants/consts.dart';
import '../../constants/otherConsts/other_consts.dart';
import '../../model/MessageData.dart';

class MessageCard extends StatelessWidget {
  final MessageData message;

  MessageCard({Key? key, required this.message}) : super(key: key);

  bool? isMe;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    if (CacheHelper.getDataToSharedPrefrence('token') == message.fromId) {
      isMe = true;
    } else {
      isMe = false;
    }
    return Container(
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isMe! ? greenMessage() : grayMessage(),
          K.fixed10h,
        ],

      ),
    );
  }

  Widget grayMessage() {
    return Card(
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.w),
              topRight: Radius.circular(15.w),
              bottomRight: Radius.circular(15.w)
          )
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
        child: CustomText(
          text: message.msg,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget greenMessage() {
    return Card(
      color: Const.mainColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.w),
              topRight: Radius.circular(15.w),
              bottomLeft: Radius.circular(15.w)
          )
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
        child: CustomText(
            text: message.msg,
            fontWeight: FontWeight.normal,
            color: Colors.white),
      ),
    );
  }
}
