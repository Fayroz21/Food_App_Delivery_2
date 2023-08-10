import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/components/Custom_Text.dart';
import 'package:food_delivery_app/components/Custom_appBar.dart';
import 'package:food_delivery_app/components/Custom_backGround2.dart';
import 'package:food_delivery_app/components/Custom_card.dart';
import 'package:food_delivery_app/screens/chat_screen/chat_details_screen.dart';
import 'package:food_delivery_app/services/firebase_services.dart';
import 'package:food_delivery_app/shared_preference/shared_pref.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Constants/consts.dart';
import '../../constants/otherConsts/other_consts.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  Services services = Services();
  dynamic uid = CacheHelper.getDataToSharedPrefrence('token');

  @override
  Widget build(BuildContext context) {
    return CustomBackGround2(
      child: SingleChildScrollView(
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
            StreamBuilder<QuerySnapshot>(
              // stream: services.cloudStore.collection('chats').snapshots(),
              stream: Services.cloudStore
                  .collection('chats')
                  .where('uid', isNotEqualTo: uid)
                  .snapshots(),
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

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CustomText(
                      text: 'Loading...',
                      color: Const.mainColor,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  List<Timestamp>? lastTime = [];
                  List<dynamic> loadedData = snapshot.data!.docs.map((e) {
                    Map<String, dynamic>? data =
                        e.data()! as Map<String, dynamic>?;
                    lastTime.add(data!['time']);
                    return data;
                  }).toList();
                  print(loadedData);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: loadedData.length,
                    itemBuilder: (context, index) {
                      final DateTime lastDate = lastTime[index].toDate();
                      return InkWell(
                        onTap: () {
                          Get.to(() => ChatDetails(
                                user: loadedData[index],
                              ));
                        },
                        child: CustomCard(
                          userImage: loadedData[index]['image'],
                          userName: loadedData[index]['name'],
                          subtitleString: loadedData[index]['title'],
                          trailing:
                              Text(DateFormat('hh:mm a').format(lastDate)),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
