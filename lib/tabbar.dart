import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_you/chat.dart';
import 'package:remind_you/group/group.dart';
import 'package:remind_you/project.dart';
import 'package:remind_you/signup/signup-details.dart';
import 'package:remind_you/task.dart';

class Tabbar1 extends StatefulWidget {
 // final String ownMobile;
  Tabbar1({Key key,}) : super(key: key);

  @override
  _Tabbar1State createState() => _Tabbar1State();
}

class _Tabbar1State extends State<Tabbar1> {
  String own_image;
  String own;
   final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;

  @override
    initState()  {
    // TODO: implement initState
    super.initState();
      getphn();
    
    

      if (Platform.isIOS) {
            iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
                // save the token  OR subscribe to a topic here
            });

            _fcm.requestNotificationPermissions(IosNotificationSettings());
        }


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

 
        
   


    

  }


    getphn() async {
    
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    final phn = currentUser.phoneNumber;
    print('thissssssssssssssssssssssssssss');
setState(()   {
  
       own= phn.replaceAll('+', '').replaceAll(' ', '');
       print(own);
      
});
   // print(this.phone); 
   
     requestpermission();
    
    getOwnImage();
    _saveDeviceToken();
    print('reporting from tabbar');
    print(own);
  }

       _saveDeviceToken() async {
    // Get the current user
   // String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          // .collection('users')
          // .document(uid)
          // .collection('tokens')
          // .document(fcmToken);
          .collection('contacts')
          .document(own)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
    }



requestpermission() async {
  print('request permission called');
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('permission granted');
    }
  }
  getOwnImage() {
    print('========================THIS is get own image');
    print(own);
    var data = Firestore.instance
        .collection('contacts')
        .document('$own')
        .get(); 
    data.then((event){
      print('testing working');
      var img= event.data['own_image'];
     //print(img);
      setState((){
        //own_image = 'https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1597881600&v=beta&t=62QQlPsLiUaKWY12hZXXzyXIU4tc-10XliFJPXe2CXY';
          own_image=img;
        print(own_image);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4, //news tab temp removed
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(21, 137, 229, 1),
                    Color.fromRGBO(2, 205, 126, 1),
                  ],
                ),
                // color: Color.fromRGBO(7, 94, 84, 1)
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.chat,
                    size: 20,
                  ),
                  //text: 'Chats',
                  child: Text(
                    'Chats',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.group_work,
                    size: 20,
                  ),
                  child: Text(
                    'Groups',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.track_changes,
                    size: 20,
                  ),
                  child: Text(
                    'Projects',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.timeline,
                    size: 20,
                  ),
                  child: Text(
                    'Tasks',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                // Tab(
                //   icon: Icon(Icons.chat, size: 20,),
                //   child: Text('Profile', style: TextStyle(fontSize: 10),),
                // ),

                //temporarily deleted news tab 29.3.20
                // Tab(
                //   icon: Icon(
                //     Icons.announcement,
                //     size: 20,
                //   ),
                //   child: Text(
                //     'News',
                //     style: TextStyle(fontSize: 10),
                //   ),
                // ),
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Commtrails'),
                Row(
                  children: <Widget>[
                    Icon((Icons.search)),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Container(
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        // icon: Icon(
                        //   Icons.more_vert,
                        //   color: Colors.white,
                        // ),

                        icon: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            radius: 20,
                           backgroundImage: NetworkImage(own_image),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        items: <String>['Profile', 'Web version', 'Details']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            onTap: () {
                              switch (value) {
                                case 'Profile':
                                  print('in profile');
                                  break;

                                case 'Web version':
                                  print('in Web version');
                                  //  openscanner();
                                  break;

                                  case 'Details':
                                  print('in Details');
                                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignupDetails(phone: own,)));
                      
                                  break;
                                default:
                              }
                            },
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      )),
                    )
                  ],
                )
              ],
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Chat(ownMobile: own),
              Group(ownMobile: own),
              Project(),
              Task(),
              //Icon(Icons.directions_transit), news tab space
              // Icon(Icons.directions_transit),
              // Icon(Icons.directions_transit),
              // Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
