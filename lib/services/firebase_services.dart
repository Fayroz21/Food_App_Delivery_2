import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_delivery_app/model/MessageData.dart';
import 'package:food_delivery_app/shared_preference/shared_pref.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Services {
  //Auth has a class we will tak an object
  final auth = FirebaseAuth.instance;

  //We need the current user
  static Rxn<User> currentFirebaseUser = Rxn<User>();

  //Firebase database
  final store = FirebaseDatabase.instance;
  static final cloudStore = FirebaseFirestore.instance;

  //Get conversation id
  static String getConversationId(String id) =>
      currentFirebaseUser.value!.uid.hashCode <= id.hashCode
          ? '${currentFirebaseUser.value!.uid}_$id'
          : '${id}_${currentFirebaseUser.value!.uid}';

  //Get all messages of specific conversation
  //chat users 'uid'
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      String chatUserId) {
    return cloudStore
        .collection('chatsMessages/${getConversationId(chatUserId)}/message')
        .snapshots();
  }

  //send message
  Future<void> sendMessage(dynamic chatUser, String msg) async {
    //current time
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final timeDate = DateTime.now();

    //set message to be sent
    final MessageData message = MessageData(
        sentTime: time,
        fromId: CacheHelper.getDataToSharedPrefrence('token'),
        msg: msg,
        toId: chatUser['uid']);

    //Get collection of chat messages
    final ref = Services.cloudStore
        .collection('chatsMessages/${getConversationId(chatUser['uid'])}/message');

    await ref.doc(time).set(message.toJson());

    //Update last time to text
    chatUser['time'] = timeDate;

    final QuerySnapshot querySnapshot =  await cloudStore.collection('chats').where('uid', isEqualTo: chatUser['uid']).get();
    if(querySnapshot.docs.isNotEmpty){
      querySnapshot.docs.first.reference.update(chatUser);
    }

  }
}
