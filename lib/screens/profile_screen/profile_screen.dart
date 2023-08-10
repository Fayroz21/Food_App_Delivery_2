
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Constants/consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading:
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async{}
            ),
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height /5,
            flexibleSpace: FlexibleSpaceBar(
              // background:imagecontroller.imgPath != null?Image.file(File(imagecontroller.imgPath!), fit: BoxFit.cover,):Image.asset('assets/images/profilerectangle-removebg-preview.png'),
            ),
          ),
          SliverToBoxAdapter(
            child:Container(
                height: 600.h,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0.h, horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orangeAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Member Gold',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Anam Wusono',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp),
                          ),
                          SizedBox(
                            width: 110.w,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: Const.mainColor,
                          )
                        ],
                      ),
                      Text(
                        'anamwp66@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 90.h,
                            width: 330.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                            ),
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                            child: Image.asset(
                                              'assets/images/Voucher Icon.png',
                                              width: 40.w,
                                              height: 90.h,
                                            )),
                                        Container(
                                          width: 200.w,
                                          child: Center(
                                            child: Text(
                                              'You Have 3 Voucher',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Favorites',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),

                      Obx(() {
                        return Container();
                        // if( menuu.favorites.isEmpty){
                        //   return Padding(
                        //     padding: EdgeInsets.symmetric(vertical: 60.0.h),
                        //     child: Center(child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SizedBox(height: 100.h,width: 100.w,child:Image.asset('assets/images/heart-removebg-preview.png'),),
                        //         SizedBox(height: 10.h,),
                        //         Text('Please add your favorite products', style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 20.sp,
                        //         ),)
                        //
                        //       ],
                        //     ),),
                        //   );
                        // } else{
                        //   return Expanded(
                        //     child: ListView.builder(
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.vertical,
                        //       itemCount: menuu.favorites.length,
                        //       itemBuilder:(BuildContext context, index) {
                        //         return Column(
                        //           children: [
                        //             Container(
                        //               transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        //               child: Stack(
                        //                 children: [
                        //                   Container(
                        //                     height: 80.h,
                        //                     width: double.infinity,
                        //                     decoration: BoxDecoration(
                        //                         borderRadius: BorderRadius.circular(10),
                        //                         color: Colors.grey
                        //                     ),
                        //                     child: Row(
                        //                       children: [
                        //                         Container(
                        //                           height: 100.h,
                        //                           width: 80.w,
                        //                           decoration: BoxDecoration(
                        //                             image: DecorationImage(
                        //                               image: NetworkImage(
                        //                                   menuu.favorites[index].pic.toString()),
                        //                               fit: BoxFit.fill,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         SizedBox(
                        //                           width: 5.w,
                        //                         ),
                        //                         Padding(
                        //                           padding:
                        //                           EdgeInsets.only(top: 15, right: 25, left: 10),
                        //                           child: Column(
                        //                             children: [
                        //                               Text(
                        //                                 menuu.favorites[index].name.toString(),
                        //                                 style: TextStyle(
                        //                                   fontWeight: FontWeight.bold,
                        //                                 ),
                        //                                 maxLines: 1,
                        //                                 overflow: TextOverflow.ellipsis,
                        //                               ),
                        //                               SizedBox(height: 5.h,),
                        //                               Text(
                        //                                 '\$ ${menuu.favorites[index].price.toString()}',
                        //                                 style: TextStyle(
                        //                                   fontWeight: FontWeight.bold,
                        //                                   color: greencolor,
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //
                        //
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //             SizedBox(height: 20.h,),
                        //           ],
                        //         );},
                        //     ),
                        //   );
                        // }
                      },

                      )],
                  ),
                )),

          ),

        ],
      ),
    );
  }
}
