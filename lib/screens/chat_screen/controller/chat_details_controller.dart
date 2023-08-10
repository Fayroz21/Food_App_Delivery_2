import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../model/MessageData.dart';
import '../../../services/firebase_services.dart';

class ChatDetailsController extends GetxController{
  //Services
  Services services = Services();

  //for storing all mesages
  final RxList listMsg = [].obs;

  //input message controller
  Rx<TextEditingController> textController = TextEditingController().obs;

  //send message function on tap
  sendMessage(dynamic chatUser){
    if(textController.value.text.isNotEmpty){
      services.sendMessage(chatUser, textController.value.text);
      textController.value.text = '';
    }
  }

}