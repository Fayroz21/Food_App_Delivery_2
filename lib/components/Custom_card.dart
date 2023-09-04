import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Custom_Text.dart';
import 'dart:io';


class CustomCard extends StatelessWidget {

  String? userImage;
  String? userName;
  String? subtitleString;
  Widget? trailing;

  CustomCard({Key? key,
    required this.userImage,
    required this.userName,
    required this.subtitleString,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(userImage);
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.w)),
      child: ListTile(
        isThreeLine: false,
        // minVerticalPadding: 20.h,
        contentPadding: EdgeInsets.only(
            top: 10.w, bottom: 10.w, right: 8.w, left: 20.w),
        leading: SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: Image.asset(
              '$userImage',
              width: 62.w,
              height: 60.h,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Image.file(
                  File('$userImage'),
                  fit: BoxFit.fill,
                  width: 62.w,
                  height: 60.h,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/user/avatar.jpg',
                    );
                  },
                );
              },
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: CustomText(text: userName),
        subtitle: CustomText(text : subtitleString, fontWeight: FontWeight.normal,),
        trailing: trailing,
      ),
    );
  }
}