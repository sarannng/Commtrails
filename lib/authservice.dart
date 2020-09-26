import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remind_you/main.dart';
import 'package:remind_you/signup/onboard/login.dart';
import 'package:remind_you/signup/onboard/welcome.dart';
import 'package:remind_you/tabbar.dart';
import 'getphone.dart';
// class GetPhone {
//   String phonee;

//   getphn() async {
//     FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//     final phn = currentUser.phoneNumber;
//     print('thissssssssssssssssssssssssssss');
//     print(phn.toString());
//     phonee = phn.toString();

//     print('object');
//     // print(this.phone);
     
//   }
// }

class AuthService {
  //Handles Auth
  Tabbar1 tb = Tabbar1();

  String phone;
  String name;
  String img;
  String phonee;
    getphn() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    final phn = currentUser.phoneNumber;
    print('thissssssssssssssssssssssssssss');
    print(phn.toString());
    phonee = phn.toString();

    print('object');
    // print(this.phone);
    return phonee;
     
  }
 
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        
        builder: (BuildContext context, snapshot) {

          // var n= GetPhone().getphn().toString();
    
          //    print('this is n'+n);
//                 GetPhone().getphn();
//                // print('this is n'+n );
//                 print('this is phone'+ phonee);
//                 var mobile= phonee.replaceAll('+', '');

//           var data =
//            Firestore.instance.collection('contacts').document('$mobile').snapshots();
//           data.listen((value) async {
//             img = await value.data['own_image'];
//             name = await value.data['own_name'];
//             print(img);
//             print(name);     
          
//                 print( snapshot.data);
//    });
// print('nameeeeeeeeeeeeeeee');
// print(name);  && name!=null

    
          if (snapshot.hasData) {
            return Tabbar1();
          } else {
            return Welcome();
          }
         

          
          
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    BuildContext context;
    print('object');
    // return Tabbar1();
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }


}
