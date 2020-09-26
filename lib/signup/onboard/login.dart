import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:remind_you/signup/signup-details.dart';
import 'package:remind_you/tabbar.dart';

import '../../authservice.dart';

class Login extends StatefulWidget {
  final String ownnum;
  Login({Key key, this.ownnum}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = TextEditingController();

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  @override
  Future<void> initState() {
    super.initState();
    // if (Platform.isIOS) {
    //     iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
    //         // save the token  OR subscribe to a topic here
    //     });

    //     _fcm.requestNotificationPermissions(IosNotificationSettings());
    // }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );

    //  _saveDeviceToken();
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network('https://www.hrtrails.in/img/home/logo1.png'),
              Column(
                children: <Widget>[
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  //   child: TextField(
                  //     controller: _controller,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       icon: Icon(Icons.person_add),
                  //       helperText: 'Enter your id here',
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 32,
                  // ),
                  // RaisedButton(
                  //     color: Colors.blue,
                  //     child: Text(
                  //       'Login',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       if (_controller.text.isNotEmpty) {
                  //         var mobNum= _controller.text.trim().replaceAll('+', '');

                  //         // Navigator.pushReplacement(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (BuildContext context) => Tabbar1(
                  //         //             ownMobile: '91$mobNum')));
                  //                     //ownMobile: _controller.text.trim()))); contact collection shift 19.6.20
                  //       }

                  //       //_controller.clear();
                  //     }),

                  // RaisedButton(
                  //     color: Colors.green,
                  //     child: Text(
                  //       'Sign Up',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (BuildContext context) =>
                  //       //             SignupDetails()));

                  //       //_controller.clear();
                  //     }),

                  //code for OTP

                  Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    hintText: 'Enter phone number'),
                                onChanged: (val) {
                                  setState(() {
                                    this.phoneNo =
                                        '+91${val.replaceAll(' ', '').trim()}';
                                  });
                                },
                              )),
                          codeSent
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    decoration:
                                        InputDecoration(hintText: 'Enter OTP'),
                                    onChanged: (val) {
                                      setState(() {
                                        this.smsCode = val;
                                      });
                                    },
                                  ))
                              : Container(),
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: RaisedButton(
                                  child: Center(
                                      child: codeSent
                                          ? Text('Login')
                                          : Text('Verify')),
                                  onPressed: () async {
                                    var _phoneNo= phoneNo.replaceAll('+', '');
                                    if(phoneNo!=null){
                                       await Firestore.instance
                                          .collection('contacts')
                                          .document('$_phoneNo')
                                          // .collection('${number.text}')
                                          //.document('${number.text}')
                                          .setData({
                                        'own_number': '$_phoneNo',
                                      });
                                    }

                                    codeSent
                                        ? () async {
                                          print('phone'+ phoneNo);
                                          if(phoneNo!= null){
                                        await Firestore.instance
                                          .collection('contacts')
                                          .document('91$phoneNo')
                                          // .collection('${number.text}')
                                          //.document('${number.text}')
                                          .setData({
                                        'own_number': '91$phoneNo',
                                      });

                                      await AuthService().signInWithOTP(
                                            smsCode, verificationId);

                                        Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => SignupDetails(phone: phoneNo)));

                                     }}
                                        : verifyPhone(phoneNo);

                               await FirebaseAuth.instance
                                        .currentUser()
                                        .then((value) async {
                                     

                                      if (value != null) {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        SignupDetails(phone: _phoneNo,)));
                                      } else {
                                        // Navigator.of(context).pop();
                                        print('sdf');
                                      }
                                    }
                                    );
                                  })),

                          //       Padding(
                          // padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          // child: RaisedButton(
                          //     child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                          //     onPressed: () {
                          //       codeSent ? AuthService().signInWithOTP(smsCode, verificationId): (){};
                          //     }))
                        ],
                      )),
                ],
              ),
              Image.network('https://www.hrtrails.in/img/home/divi.png'),
              Text(
                'By: OEPP Innovations',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
