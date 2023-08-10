import 'package:firebase_database/firebase_database.dart';

class UserDetails {
  UserDetails({
      this.image, 
      this.mobileNum, 
      this.firstN, 
      this.isEmailMe, 
      this.lastN, 
      this.location, 
      this.payment, 
      this.isStayLogin, 
      this.userName,});

  UserDetails.fromJson(dynamic json) {
    image = json['image'];
    mobileNum = json['mobileNum'];
    firstN = json['firstN'];
    isEmailMe = json['isEmailMe'];
    lastN = json['lastN'];
    location = json['location'];
    payment = json['payment'];
    isStayLogin = json['isStayLogin'];
    userName = json['userName'];
  }
  String? image;
  String? mobileNum;
  String? firstN;
  bool? isEmailMe;
  String? lastN;
  String? location;
  String? payment;
  bool? isStayLogin;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['mobileNum'] = mobileNum;
    map['firstN'] = firstN;
    map['isEmailMe'] = isEmailMe;
    map['lastN'] = lastN;
    map['location'] = location;
    map['payment'] = payment;
    map['isStayLogin'] = isStayLogin;
    map['userName'] = userName;
    return map;
  }



}