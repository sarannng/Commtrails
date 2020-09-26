import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:remind_you/authservice.dart';
import 'package:remind_you/chat.dart';
import 'package:remind_you/db_manager.dart';
import 'package:remind_you/encrypt-fun.dart';
import 'package:remind_you/group/group.dart';
import 'package:remind_you/project.dart';
import 'package:remind_you/signup/signup-details.dart';
import 'package:remind_you/tabbar.dart';
import 'package:remind_you/task.dart';
import 'package:sqflite/sql.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commtrails',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Tabbar(),
     // home: Login(),
     debugShowCheckedModeBanner: false,
    home: AuthService().handleAuth()
    );
  }
}

//test login page. 15.6.20

// class Login extends StatefulWidget {
//   Login({Key key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final _controller = TextEditingController();

//   final Firestore _db = Firestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   StreamSubscription iosSubscription;
//   final formKey = new GlobalKey<FormState>();

//   String phoneNo, verificationId, smsCode;

//   bool codeSent = false;
//     @override
//     Future<void> initState()  {
//         super.initState();
//         if (Platform.isIOS) {
//             iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
//                 // save the token  OR subscribe to a topic here
//             });

//             _fcm.requestNotificationPermissions(IosNotificationSettings());
//         }


//           _fcm.configure(
//           onMessage: (Map<String, dynamic> message) async {
//             print("onMessage: $message");
//             showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                         content: ListTile(
//                         title: Text(message['notification']['title']),
//                         subtitle: Text(message['notification']['body']),
//                         ),
//                         actions: <Widget>[
//                         FlatButton(
//                             child: Text('Ok'),
//                             onPressed: () => Navigator.of(context).pop(),
//                         ),
//                     ],
//                 ),
//             );
//         },
//         onLaunch: (Map<String, dynamic> message) async {
//             print("onLaunch: $message");
//             // TODO optional
//         },
//         onResume: (Map<String, dynamic> message) async {
//             print("onResume: $message");
//             // TODO optional
//         },
//       );

//     //  _saveDeviceToken();
        
   


//     }

//     Future<void> verifyPhone(phoneNo) async {
//     final PhoneVerificationCompleted verified = (AuthCredential authResult) {
//       AuthService().signIn(authResult);
//     };

//     final PhoneVerificationFailed verificationfailed =
//         (AuthException authException) {
//       print('${authException.message}');
//     };

//     final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
//       this.verificationId = verId;
//       setState(() {
//         this.codeSent = true;
//       });
//     };

//     final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
//       this.verificationId = verId;
//     };

//     await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         timeout: const Duration(seconds: 5),
//         verificationCompleted: verified,
//         verificationFailed: verificationfailed,
//         codeSent: smsSent,
//         codeAutoRetrievalTimeout: autoTimeout);
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Image.network('https://www.hrtrails.in/img/home/logo1.png'),
//               Column(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                     child: TextField(
//                       controller: _controller,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.person_add),
//                         helperText: 'Enter your id here',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 32,
//                   ),
//                   RaisedButton(
//                       color: Colors.blue,
//                       child: Text(
//                         'Login',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         if (_controller.text.isNotEmpty) {
//                           var mobNum= _controller.text.trim().replaceAll('+', '');

//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) => Tabbar1(
//                                       ownMobile: '91$mobNum')));
//                                       //ownMobile: _controller.text.trim()))); contact collection shift 19.6.20
//                         }

//                         //_controller.clear();
//                       }),



//                   RaisedButton(
//                       color: Colors.green,
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     SignupDetails()));

//                         //_controller.clear();
//                       }),

//                       //code for OTP

//                       Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                   padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                   child: TextFormField(
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(hintText: 'Enter phone number'),
//                     onChanged: (val) {
//                       setState(() {
//                         this.phoneNo = '+91${val.replaceAll(' ', '').trim()}';
//                       });
//                     },
//                   )),
//                   codeSent ? Padding(
//                   padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                   child: TextFormField(
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(hintText: 'Enter OTP'),
//                     onChanged: (val) {
//                       setState(() {
//                         this.smsCode = val;
//                       });
//                     },
//                   )) : Container(),
//               Padding(
//                   padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                   child: RaisedButton(
//                       child: Center(child: codeSent ? Text('Login'):Text('Verify')),
//                       onPressed: () {
//                         codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
//                       }))
//             ],
//           )),


//                 ],
//               ),
//               Image.network('https://www.hrtrails.in/img/home/divi.png'),
//               Text(
//                 'By: OEPP Innovations',
//                 style: TextStyle(
//                     color: Colors.black38,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// firestore chat app test 5.6.20 start
// class Tabbar extends StatefulWidget {
//   final String ownMobile;
//   Tabbar({Key key, this.ownMobile}) : super(key: key);

//   @override
//   _TabbarState createState() => _TabbarState();
// }

// class _TabbarState extends State<Tabbar> {
//   String own_image;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getOwnImage();
//   }

//   getOwnImage() {
//     var data = Firestore.instance
//         .collection('${widget.ownMobile}')
//         .document('${widget.ownMobile}')
//         .snapshots();
//     data.listen((event) {
//       setState(() {
//         own_image = event.data['own_image'];
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 4, //news tab temp removed
//         child: Scaffold(
//           appBar: AppBar(
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromRGBO(21, 137, 229, 1),
//                     Color.fromRGBO(2, 205, 126, 1),
//                   ],
//                 ),
//                 // color: Color.fromRGBO(7, 94, 84, 1)
//               ),
//             ),
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(
//                     Icons.chat,
//                     size: 20,
//                   ),
//                   //text: 'Chats',
//                   child: Text(
//                     'Chats',
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Tab(
//                   icon: Icon(
//                     Icons.group_work,
//                     size: 20,
//                   ),
//                   child: Text(
//                     'Groups',
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Tab(
//                   icon: Icon(
//                     Icons.track_changes,
//                     size: 20,
//                   ),
//                   child: Text(
//                     'Projects',
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Tab(
//                   icon: Icon(
//                     Icons.timeline,
//                     size: 20,
//                   ),
//                   child: Text(
//                     'Tasks',
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 // Tab(
//                 //   icon: Icon(Icons.chat, size: 20,),
//                 //   child: Text('Profile', style: TextStyle(fontSize: 10),),
//                 // ),

//                 //temporarily deleted news tab 29.3.20
//                 // Tab(
//                 //   icon: Icon(
//                 //     Icons.announcement,
//                 //     size: 20,
//                 //   ),
//                 //   child: Text(
//                 //     'News',
//                 //     style: TextStyle(fontSize: 10),
//                 //   ),
//                 // ),
//               ],
//             ),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('Commtrails'),
//                 Row(
//                   children: <Widget>[
//                     Icon((Icons.search)),
//                     // SizedBox(
//                     //   width: 20,
//                     // ),
//                     Container(
//                       child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                         // icon: Icon(
//                         //   Icons.more_vert,
//                         //   color: Colors.white,
//                         // ),

//                         icon: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white, width: 3),
//                               shape: BoxShape.circle),
//                           child: CircleAvatar(
//                             radius: 20,
//                             backgroundImage: NetworkImage(own_image),
//                             backgroundColor: Colors.transparent,
//                           ),
//                         ),
//                         items: <String>['Profile', 'Web version']
//                             .map((String value) {
//                           return new DropdownMenuItem<String>(
//                             onTap: () {
//                               switch (value) {
//                                 case 'Profile':
//                                   print('in profile');
//                                   break;

//                                 case 'Web version':
//                                   print('in Web version');
//                                   //  openscanner();
//                                   break;
//                                 default:
//                               }
//                             },
//                             value: value,
//                             child: new Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (_) {},
//                       )),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             centerTitle: true,
//           ),
//           body: TabBarView(
//             children: [
//               Chat(ownMobile: widget.ownMobile),
//               Group(),
//               Project(),
//               Task(),
//               //Icon(Icons.directions_transit), news tab space
//               // Icon(Icons.directions_transit),
//               // Icon(Icons.directions_transit),
//               // Icon(Icons.directions_transit),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// firestore chat app test 5.6.20 start

class Sqldbtest extends StatefulWidget {
  Sqldbtest({Key key}) : super(key: key);

  @override
  _SqldbtestState createState() => _SqldbtestState();
}

class _SqldbtestState extends State<Sqldbtest> {
  final DatabaseManager dbmanager = new DatabaseManager();
  final _chatcontroller = TextEditingController();
  final _formkey = new GlobalKey<FormState>();

  Encrypt _encrypt = new Encrypt();

  Chats chats;
  List<Chats> chatlist;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Sql lite'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
                child: Column(
              children: <Widget>[
                TextFormField(
                  key: _formkey,
                  controller: _chatcontroller,
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Enter some message ',
                  decoration: InputDecoration(
                    labelText: 'Message',
                  ),
                ),
              ],
            )),
            RaisedButton(
              onPressed: () {
                sendchat(context);
              },
              color: Colors.blueAccent,
              child: Text('Send'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Sqldbtest()));
              },
              color: Colors.red,
              child: Text('refresh'),
            ),
            Expanded(
                child: FutureBuilder(
                    future: dbmanager.getmessage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        chatlist = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatlist == null ? 0 : chatlist.length,
                          itemBuilder: (context, index) {
                            Chats ct = chatlist[index];
                            return ListTile(

                                ////////////MESSAGE DECODES ONLY HERE///////////
                                // title: Text( _encrypt.decryption(ct.message)),
                                );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('THere is error ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Future<void> sendchat(BuildContext context) async {
    //if( _formkey.currentState.validate()){
    if (chats == null) {
      // Chats chats= new Chats(  message: _chatcontroller.text);
      Chats chats =
          new Chats(message: _encrypt.encryption(_chatcontroller.text));

//                        Chats ct= chatlist[0];

//                        print('========================');
//                         print('this is message: ${ct.message}');
//                                  var dmess=     _encrypt.decryption(ct.message);
// print('==++++++++++++++++++++');
//                         print(dmess);
//                         print('==++++++++++++++++++++');
// print('========================');
//                        print(   _encrypt.encryption(_chatcontroller.text));
      dbmanager.insertmessage(chats).then((value) => _chatcontroller.clear());
      print('chats added in database ${chats.id}');
    }

    // }
  }
}
