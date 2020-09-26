import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_you/contact-page.dart';
import 'package:remind_you/message.dart';

class Chat extends StatefulWidget {
  final String ownMobile;
  Chat({Key key, this.ownMobile}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
   String own_mobile;
  String unread_message_count;
  Color namecolor;
  Stream path;
  String message_path;
  @override
  void initState() {
    //  checkundeliveredmessages();
    setmobile();
  //  messagepathdecider();
    unseenmessagecount();
    super.initState();
  }

  setmobile(){
    own_mobile=widget.ownMobile;
    print('own mobile from chat'+ own_mobile);
  }
  // test() {
  //   var d1 = Firestore.instance
  //       .collection('test')
  //       .where('name', isEqualTo: 'sarang')
  //       //.where('aa', isLessThan: 124)
  //       // .where('aa', isGreaterThan: 124)
  //       .snapshots();

  //   d1.listen((event) {
  //     print('test doc length');
  //     print(event.documents.length);

  //     for (int i = 0; i < event.documents.length; i++) {
  //       print(event.documents[i].documentID);

  //       var d1 = Firestore.instance
  //           .collection('test')
  //           .where('aa', isLessThan: 124)
  //           .snapshots();
  //       d1.listen((event) {
  //         event.documents.length;
  //         for (int i = 0; i < event.documents.length; i++) {
  //            print(event.documents[i].documentID);
  //           Firestore.instance
  //               .collection('test')
  //               .document(event.documents[i].documentID)
  //               .updateData({'name': 'Bholenath'});
  //         }

  //         // var d1 = Firestore.instance
  //         //     .collection('test')
  //         //     .where('aa', isGreaterThan: 124)
  //         //     .snapshots();
  //         // d1.listen((event) {
  //         //   event.documents.length;
  //         //   for (int i = 0; i < event.documents.length; i++) {
  //         //           print(event.documents[i].documentID);
  //         //     Firestore.instance
  //         //         .collection('test')
  //         //         .document(event.documents[i].documentID)
  //         //         .updateData({'name': 'Bholenath'});
  //         //   }
  //         // });
  //       }); 

  //       var d2 = Firestore.instance
  //             .collection('test')
  //             .where('aa', isGreaterThan: 124)
  //             .snapshots();

  //         d2.listen((event) {
  //           event.documents.length;
  //           for (int i = 0; i < event.documents.length; i++) {
  //                   print(event.documents[i].documentID);
  //             Firestore.instance
  //                 .collection('test')
  //                 .document(event.documents[i].documentID)
  //                 .updateData({'name': 'Bholenath'});
  //           }
  //         });
  //     }

  //     // print(event.documents.elementAt(0).documentID);
  //   });
  // }

  // messagepathdecider() {
  //   var data = Firestore.instance
  //       .collection('$own_mobile')
  //       .document('$own_mobile')
  //       .collection('message')
  //       .document('$own_mobile')
  //       .snapshots();

  //   data.listen((event) {
  //     if (event.data['first'] == true) {
  //       var path1 = event.data['path'];

  //       print(path1);
  //             // this path will be the location of messaage collection of reciver

  //       setState(() { 
  //        // path = Firestore.instance.collection(path1).snapshots();
  //         path=  Firestore.instance.collection('$path1/chats').snapshots();
  //           message_path=path1;
  //           test(message_path);
  //         });
     
          
     
  //     } else {
         
  //     setState(() {
  //         path = Firestore.instance
  //           .collection(
  //               '/$own_mobile/$own_mobile/message/${widget.id}/chats')  // 15.6.20 for setting all the delivered messages as true first get every document id and then loop in for setting delivered false.
  //           .snapshots(); // usual query to thr messages/chats whatever it is, i.e own collection.
 
  //       // path = Firestore.instance
  //       //     .collection(
  //       //         '/1235/1235/message/${widget.id}/chats')
  //       //     .snapshots(); 

  //             message_path= '/${widget.own_mobile}/${widget.own_mobile}/message/${widget.id}';
  //     test(message_path);
  //     });
  //     }
  //   });
  // }

   test(messagePath) {
    var d1 = Firestore.instance
        .collection('$messagePath/chats')
        .where('seen', isEqualTo: false)
        //.where('aa', isLessThan: 124)
        // .where('aa', isGreaterThan: 124)
        .snapshots();

    d1.listen((event) {
      print('test doc length');
      print(event.documents.length);

      for (int i = 0; i < event.documents.length; i++) {
        print(event.documents[i].documentID);

        var d1 = Firestore.instance
            .collection('$messagePath/chats')
            .where('sender', isLessThan: int.parse('$own_mobile '))
            .snapshots();
        d1.listen((event) {
          event.documents.length;
          for (int i = 0; i < event.documents.length; i++) {
             print(event.documents[i].documentID);
            Firestore.instance
                .collection('$messagePath/chats')
                .document(event.documents[i].documentID)
                .updateData({'seen': true});
          }

          // var d1 = Firestore.instance
          //     .collection('test')
          //     .where('aa', isGreaterThan: 124)
          //     .snapshots();
          // d1.listen((event) {
          //   event.documents.length;
          //   for (int i = 0; i < event.documents.length; i++) {
          //           print(event.documents[i].documentID);
          //     Firestore.instance
          //         .collection('test')
          //         .document(event.documents[i].documentID)
          //         .updateData({'name': 'Bholenath'});
          //   }
          // });
        }); 

        var d2 = Firestore.instance
              .collection('$messagePath/chats')
              .where('sender', isGreaterThan: int.parse('$own_mobile '))
              .snapshots();

          d2.listen((event) {
            event.documents.length;
            for (int i = 0; i < event.documents.length; i++) {
                    print(event.documents[i].documentID);
              Firestore.instance
                  .collection('$messagePath/chats')
                  .document(event.documents[i].documentID)
                  .updateData({'sender': true});
            }
          });
      }

      // print(event.documents.elementAt(0).documentID);
    });
  }


  unseenmessagecount() {
    print(own_mobile);
    var data = Firestore.instance
        .collection('9993171180')
      //  .document('9993171180').snapshots().first;
        .document('9993171180')
        .collection('message')
        .document('8ZDZKJEC2QaFqDHscaxz')  
        .collection('chats')
        .where('delivered',
            isEqualTo:
                false) //==================12.6.20 here is the issue============================
     //   .where('sender', isLessThan: int.parse(own_mobile))
        // .where('sender', isGreaterThan: int.parse(own_mobile))
        .snapshots();

//   var data1= Firestore.instance.collection('$own_mobile').document('$own_mobile').collection('message').document('8ZDZKJEC2QaFqDHscaxz').collection('chats').where( 'delivered',isEqualTo: false,).snapshots();

    delivertrue(event) async {
      print('in deliver true start');
      print(event.documents.length);
      for (int i = 0; i < event.documents.length; i++) {
        var docid = await event.documents[i];
        print('in for');
        print('=======');
        print(docid.documentID);
        print('=======');
        await Firestore.instance
            .collection('9993171180')
            .document('9993171180')
            .collection('message')
            .document('8ZDZKJEC2QaFqDHscaxz')
            .collection('chats')
            .document('${docid.documentID}')
            .updateData({'delivered': true});
      }
    }

    data.listen((event) {
      print(event.documents.length);
      print(event.documents);
      print('deliver true start');
      delivertrue(event);
      setState(() {
        unread_message_count = event.documents.length.toString();
      });

      setState(() {
        if (event.documents.length > 0) {
          namecolor = Color.fromRGBO(21, 137, 229, 1);
        } else {
          namecolor = Colors.black;
        }
      });
    });
  }

//   checkundeliveredmessages(){
//    var data= Firestore.instance.collection('$own_mobile').document('$own_mobile').collection('message').document('8ZDZKJEC2QaFqDHscaxz').collection('chats').where( 'delivered',isEqualTo: false,).where( 'sender',isGreaterThan:  int.parse(own_mobile),).where( 'sender',isLessThan:  int.parse(own_mobile),).snapshots();

// //   var data1= Firestore.instance.collection('$own_mobile').document('$own_mobile').collection('message').document('8ZDZKJEC2QaFqDHscaxz').collection('chats').where( 'delivered',isEqualTo: false,).snapshots();

//    data.listen((event) {
//       print(event.documents.length );
//       print(event.documents);

//       for(int i=0; i< event.documents.length;i++){
//         var docid= event.documents[i];
//       print('=======');
//       print(docid.documentID);
//       print('=======');
//         Firestore.instance.collection('$own_mobile').document('$own_mobile').collection('message').document('8ZDZKJEC2QaFqDHscaxz').collection('chats').document('${docid.documentID}').updateData({
//           'delivered': true
//         });

//       }
//       // setState(() {
//       //   unread_message_count= event.documents.length.toString();
//       // });

//    });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(21, 137, 229, 1),
          child: Icon(Icons.contacts),
          onPressed: () async {

         //     requestpermission() async {
           print(Permission.contacts.status.toString());
    if(await Permission.contacts.request().isGranted){
      
      // Either the permission was already granted before or the user just granted it.
      print('permission granted'); 
       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ContactPage(ownMobile: own_mobile)));
       
       
    }
    
  //}
            //Firestore.instance.collection('test').document().setData({'name': 'sarang'});
               }),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            // .collection('/9993171180/9993171180/message')
              //  .collection('/$own_mobile/$own_mobile/message')
                .collection('contacts/$own_mobile/message')
          //  .collection('/+91 73898 39103/+91 73898 39103/message')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Container(
                  child: Center(
                      child: Column(
                children: <Widget>[
                  Text(
                    'Chats are loading...',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 5,
                  )
                ],
              )));
              case ConnectionState.none :
              return new Container(
                  child: Center(
                      child: Column(
                children: <Widget>[
                  Text(
                    'Connection state none...',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 5,
                  )
                ],
              )));

              
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot doc) {
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 10.0,
                      ),
                      ListTile(
                        onTap: () {
                          print(doc.documentID);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Message(
                                      id: doc.documentID,
                                      own_mobile: own_mobile,
                                      appbarImage: doc['sender_image'],
                                      appbarName: doc['sender_name']
                                      )));
                        },
                        leading: CircleAvatar(
                          radius: 30,
                            backgroundImage: NetworkImage(doc['sender_image']),
                          // backgroundImage: NetworkImage(doc['image']),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                               doc['sender_name'],
                           //   doc['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: namecolor),
                            ),
                            // Text(
                            //   doc['time'],
                            //   style: TextStyle(
                            //       color: Colors.grey,
                            //       fontSize: 13,
                            //       fontWeight: FontWeight.w600),
                            // ),
                          ],
                        ),
                        subtitle: Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Text(
                              //  doc['sender_post'],
                              //   style: TextStyle(
                              //       color: Colors.grey, fontSize: 15.0),
                              // ),

                              // CircleAvatar(
                              //   backgroundColor:   Color.fromRGBO(21, 137, 229, 1),
                              //   radius: 11,
                              //   child: Text(unread_message_count, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
                              // )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }).toList(),
              );
          }
        },
      )

          // child: ListView.builder(
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return Container(
          //           child: Column(
          //         children: <Widget>[
          //           //mark for making it dynamic
          //           Column(
          //             children: <Widget>[
          //               Divider(
          //                 height: 10.0,
          //               ),
          //               ListTile(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (BuildContext context) => Message(

          //                               )));
          //                 },
          //                 leading: CircleAvatar(
          //                   radius: 30,
          //                   backgroundImage: NetworkImage(
          //                       'https://media-exp1.licdn.com/dms/image/C5103AQHZZVDFPF0anQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Sea7OKWAI-o37VsOAr28879FhKCznJMxOef9zdFjbJ0'),
          //                 ),
          //                 title: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetw een,
          //                   children: <Widget>[
          //                     Text(
          //                       'Priyan Sir',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.w700, fontSize: 17, color: Color.fromRGBO(21, 137, 229, 1)),
          //                     ),
          //                     Text(
          //                       '11:03 pm',
          //                       style: TextStyle(
          //                           color: Colors.grey,
          //                           fontSize: 13,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //                 subtitle: Container(
          //                   padding: const EdgeInsets.only(top: 5.0),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: <Widget>[
          //                       Text(
          //                         'Cofounder CropTrails',
          //                         style:
          //                             TextStyle(color: Colors.grey, fontSize: 15.0),
          //                       ),

          //                       CircleAvatar(
          //                         backgroundColor:   Color.fromRGBO(21, 137, 229, 1),
          //                         radius: 11,
          //                         child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
          //                       )

          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),

          //           Column(
          //             children: <Widget>[
          //               Divider(
          //                 height: 10.0,
          //               ),
          //               ListTile(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (BuildContext context) => Message(

          //                               )));
          //                 },
          //                 leading: CircleAvatar(
          //                   radius: 30,
          //                   backgroundImage: NetworkImage(
          //                       'https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk'),
          //                 ),
          //                 title: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: <Widget>[
          //                     Text(
          //                       'Sarang Pal',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.w700, fontSize: 17),
          //                     ),
          //                     Text(
          //                       '12:00 pm',
          //                       style: TextStyle(
          //                           color: Colors.grey,
          //                           fontSize: 13,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //                 subtitle: Container(
          //                   padding: const EdgeInsets.only(top: 5),
          //                   child: Text(
          //                     'Intern @ OEPP',
          //                     style:
          //                         TextStyle(color: Colors.grey, fontSize: 15.0),
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //           Column(
          //             children: <Widget>[
          //               Divider(
          //                 height: 10.0,
          //               ),
          //               ListTile(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (BuildContext context) => Message(

          //                               )));
          //                 },
          //                 leading: CircleAvatar(
          //                   radius: 30,
          //                   backgroundImage: NetworkImage(
          //                       'https://media-exp1.licdn.com/dms/image/C5603AQH00HKjsaxSXQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=1VF9_L-00jLnutvefsWhogG2TU6tn_agoZrTO-vhqUE'),
          //                 ),
          //                 title: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: <Widget>[
          //                     Text(
          //                       'Dhruv Sir',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.w700, fontSize: 17),
          //                     ),
          //                     Text(
          //                       '11:03 pm',
          //                       style: TextStyle(
          //                           color: Colors.grey,
          //                           fontSize: 13,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //                 subtitle: Container(
          //                   padding: const EdgeInsets.only(top: 5.0),
          //                   child: Text(
          //                     'Director @ OEPP',
          //                     style:
          //                         TextStyle(color: Colors.grey, fontSize: 15.0),
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ],
          //       ));
          //     }),

          ),
    );
  }

}
