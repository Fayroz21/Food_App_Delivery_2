
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:food_delivery_app/screens/Login_screen/Login_screen.dart';
import 'package:food_delivery_app/screens/signup_screen/signup_screen.dart';
import 'package:food_delivery_app/shared_preference/shared_pref.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/user_info/user_info_const.dart';
import '../../../services/firebase_services.dart';
import '../../home_screen/home_screen.dart';

class LoginController extends GetxController{
  Services services = Services();
  final isLoading = false.obs;

  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookLogin facebookLogin = FacebookLogin();

  //Login
  login(email, password, context) async{
    isLoading.value = true;
    try{

      final resultAuth = await services.auth
          .signInWithEmailAndPassword(email: email, password: password);
      //Take user id
      if(resultAuth.user!.uid != null){
        Services.currentFirebaseUser.value = resultAuth.user;

        //save user id in shared preference
        await CacheHelper.saveDataToSharedPrefrence('token', resultAuth.user!.uid);

        print(resultAuth.user!.uid);
        Get.offAll(HomeScreen());

      }else{
        Get.to(() => SignupScreen());
      }
    } on FirebaseAuthException catch(e){
      final snackBar = SnackBar(
        content: Text('${e.message}', style: const TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    isLoading.value = false;
  }

  //Log out
  logOut() async{
    await services.auth.signOut();

    Get.offAll(() => LoginScreen());
    await CacheHelper.sharedPreferences!.remove('token');
    await CacheHelper.sharedPreferences!.clear();
  }


  //Login with google
  void googleSigninMethod() async{
    //1) sign in with google
    final googleSignInAccount = await googleSignIn.signIn();

    //2) ask for access from the user
    final gooleSignInAuth = await googleSignInAccount!.authentication;

    //3) take the token
    /****setp1, step2****/
    final credential = await GoogleAuthProvider.credential(
      accessToken: gooleSignInAuth.accessToken,
      idToken: gooleSignInAuth.idToken,
    );
    //sign in with credential m7tagen id 5ar ll gmail.
    //3shan lama agy ad5ol tany ad5loh 3al home 3ala tol

    final result = await services.auth.signInWithCredential(credential); ///fe el 5atwa de hy7ot el credintial fl fire base , with google
    final currentUser = await services.auth.currentUser!;

    if(result.user!.uid != null) {
      //save in shared prefrence
      await CacheHelper.saveDataToSharedPrefrence('token', currentUser.uid);

      print('User Name ${currentUser.displayName}');
      print('User email ${currentUser.email}');

      //save my user details into our firebase
      DatabaseReference userRef = services.store.ref().child('User');
      List<String>? userNameFromEmail = currentUser.displayName?.split(' ');

      await userRef.child(currentUser.uid).set({
        UserConst.userName: '${userNameFromEmail?[0]}${currentUser.uid.substring(0, 2)}',
        UserConst.stayLogIn: false,
        UserConst.emailMe: currentUser.email,
        UserConst.fName : userNameFromEmail?[0],
        UserConst.lName : userNameFromEmail?[1],
        UserConst.mobileNum : currentUser.phoneNumber,
        UserConst.payMethod: 'visa',
        UserConst.image: currentUser.photoURL,
        UserConst.location: ' ',
      });

      final now = DateTime.now();
      Timestamp timeStamp = Timestamp.fromDate(now);

      final chatUserRef = Services.cloudStore.collection('chats');
      await chatUserRef.doc(currentUser.uid).set({
        'uid' : currentUser.uid,
        'name' : userNameFromEmail?[0],
        'phone' : currentUser.phoneNumber,
        'time' : timeStamp,
        'image' : currentUser.photoURL,
        'title' : 'Order Have arrived!',
      });

      Get.to(HomeScreen());

    }
    //get to home

  }

  //login with facebook
  void signInWithFacebook() async{
    //login with facebook and return its token
    FacebookLoginResult result = await facebookLogin.logIn(customPermissions: ['email']);

    //save the token in a var to use it later
    final accessToken = result.accessToken?.token;

    //check if it is logged with the fb acc
    if(result.status == FacebookLoginStatus.success){
      final faceCredential = FacebookAuthProvider.credential(accessToken!);

      await services.auth.signInWithCredential(faceCredential);
    }

  }
}