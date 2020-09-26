import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_you/contact-page.dart';
import 'package:remind_you/group/group-message.dart';
import 'package:remind_you/message.dart';
//import 'package:shah_messenger/message.dart';

class Group extends StatefulWidget {final String ownMobile;
  Group({Key key, this.ownMobile}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
String own_mobile;
Color namecolor;
String unread_message_count;


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

 setmobile(){
    own_mobile=widget.ownMobile;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   setmobile();
  }

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
                .collection('contacts/$own_mobile/group')
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
                                  builder: (BuildContext context) => GroupMessage(
                                      id: doc.documentID,
                                      own_mobile: own_mobile,
                                      appbarImage: doc['group_image'],
                                      appbarName: doc['group_name']
                                      )));
                        },
                        leading: CircleAvatar(
                          radius: 30,
                            backgroundImage: NetworkImage(doc['group_image']),
                          // backgroundImage: NetworkImage(doc['image']),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                               doc['group_name'],
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
                              Text(
                               doc['group_status'],
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),

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