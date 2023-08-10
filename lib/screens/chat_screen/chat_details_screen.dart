import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/Constants/consts.dart';
import 'package:food_delivery_app/components/Custom_appBar.dart';
import 'package:food_delivery_app/components/Custom_backGround2.dart';
import 'package:food_delivery_app/components/Custom_card.dart';
import 'package:food_delivery_app/components/Custom_textField.dart';
import 'package:food_delivery_app/model/MessageData.dart';
import 'package:food_delivery_app/screens/chat_screen/controller/chat_details_controller.dart';
import 'package:food_delivery_app/services/firebase_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../components/Custom_Text.dart';
import '../../constants/otherConsts/other_consts.dart';
import '../../shared_preference/shared_pref.dart';
import 'message_card.dart';

class ChatDetails extends StatelessWidget {
  //user to be sent
  final user;

  ChatDetails({Key? key, required this.user}) : super(key: key);

  //getx class controller
  ChatDetailsController detailsControl = Get.put(ChatDetailsController());

  @override
  Widget build(BuildContext context) {
    print('5555555555 $user');

    return CustomBackGround2(
      image: 'assets/images/Pattern.png',
      backgroundColor: Colors.grey.withOpacity(0.1),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              func: () {
                Get.back();
              },
            ),
            K.fixed10h,
            CustomText(
              text: 'Chat',
              fontWeight: FontWeight.bold,
              size: 25.sp,
            ),
            K.fixed10h,
            CustomCard(
              userImage: user['image'],
              userName: user['name'],
              subtitleString: 'Online',
              trailing: MaterialButton(
                onPressed: () {},
                color: Color(0xFFB7EBBD),
                shape: const CircleBorder(),
                child: Icon(
                  Icons.call,
                  color: Const.mainColor,
                ),
              ),
            ),
            K.fixed10h,
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Services.getAllMessages(user['uid']),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: CustomText(
                              text: 'Something Went Wrong',
                              color: Colors.red,
                            ),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CustomText(
                              text: 'Loading...',
                              color: Const.mainColor,
                            ),
                          );
                        }

                        final data = snapshot.data?.docs;
                        detailsControl.listMsg.value = data
                                ?.map((e) => MessageData.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (detailsControl.listMsg.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: detailsControl.listMsg.length,
                            itemBuilder: (context, index) {
                              return MessageCard(
                                message: detailsControl.listMsg[index],
                              );
                            },
                          );
                        }
                        return Center(
                          child: Container(
                            child: CustomText(
                              text: ' ',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8.w),
                    child: CustomTextField(
                        hint: 'Message',
                        maxLine: null,
                        boardType: TextInputType.multiline,
                        controller: detailsControl.textController.value,
                        suffixIcon: MaterialButton(
                          onPressed: () {
                            detailsControl.sendMessage(user);
                          },
                          shape: const CircleBorder(),
                          child: Icon(Icons.send, color: Const.mainColor),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
