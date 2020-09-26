import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupMessage extends StatefulWidget {
  // final WebSocketChannel channel;
  final String id;
  final String own_mobile;
  final String appbarImage;
  final String appbarName;
  GroupMessage({
    Key key,
    this.id,
    this.own_mobile, this.appbarImage, this.appbarName,
  }) : super(key: key);

  @override
  _GroupMessageState createState() => _GroupMessageState();
}

class _GroupMessageState extends State<GroupMessage> {
  final _controller = TextEditingController();
  final _scrollcon = ScrollController();
  Alignment balignment;
  BubbleNip bnip;
  Color bcolor;
  TextStyle btextstyle;
  TextAlign btextalign;
  TextAlign btimetextalign;
  TextStyle btimestyle;
  Stream path;
  String message_path;

  @override
  void initState() {
   // checkseenmessages();
    messagepathdecider();
    
    super.initState();
  //  _scrollToBottom();

    // Timer.periodic(Duration(milliseconds: 100), (timer) {
    //     if (mounted) {
    //         _scrollToBottom();
    //     } else {
    //       timer.cancel();
    //     }
    //   });
  }


  _scrollToBottom(){
    if (_scrollcon.hasClients) 
    _scrollcon.jumpTo(_scrollcon.position.maxScrollExtent);
  }

  callscroll(){
    _scrollToBottom();
  }
  test(messagePath) {
    print('inside test query');
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
            .where('sender', isLessThan: int.parse('${widget.own_mobile}'))
            .snapshots();
        d1.listen((event) {
          event.documents.length;
          for (int i = 0; i < event.documents.length; i++) {
             print(event.documents[i].documentID);
            Firestore.instance
                .collection('$messagePath/chats')
                .document(event.documents[i].documentID)
                .updateData({'seen': true,'delivered': true});
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
              .where('sender', isGreaterThan: int.parse('${widget.own_mobile}'))
              .snapshots();

          d2.listen((event) async {
            event.documents.length;
            // for (int i = 0; i < event.  documents.length; i++) {
            //         print(event.documents[i].documentID);
            // await  Firestore.instance
            //       .collection('$messagePath/chats')
            //       .document(event.documents[i].documentID)
            //       .updateData({'seen': true, 'delivered': true});
            // }

            Firestore.instance.collection('$messagePath/seenby').document('${widget.own_mobile}').setData({ 
              'id': '${widget.own_mobile}'
            });
          });
      }

      // print(event.documents.elementAt(0).documentID);
    });
  }

//   delivertrue(event) async {
//     for (int i = 0; i < event.documents.length; i++) {
//       var docid = await event.documents[i];
//       print('=======');
//       print(docid.documentID);
//       print('=======');
//       await Firestore.instance
//           .collection('9993171180')
//           .document('9993171180')
//           .collection('message')
//           .document('8ZDZKJEC2QaFqDHscaxz')
//           .collection('chats')
//           .document('${docid.documentID}')
//           .updateData({'seen': true});
//     }
//   }

//   checkseenmessages() {
//     var data = Firestore.instance
//         .collection('9993171180')
//         .document('9993171180')
//         .collection('message')
//         .document('8ZDZKJEC2QaFqDHscaxz')
//         .collection('chats')
//         .where(
//           'seen',
//           isEqualTo: false,
//         )
//         .snapshots();

// //   var data1= Firestore.instance.collection('$own_mobile').document('$own_mobile').collection('message').document('8ZDZKJEC2QaFqDHscaxz').collection('chats').where( 'delivered',isEqualTo: false,).snapshots();

//     data.listen((event) async {
//       print(event.documents.length);
//       print(event.documents);
//       print('jfk');
//       await delivertrue(event);
//     });
//   }


  messagepathdecider() {
    var data = Firestore.instance
        .collection('contacts')
        .document('${widget.own_mobile}')
        .collection('group')
        .document('${widget.id}')
        .snapshots();

    data.listen((event) {
      if (event.data['first'] == true) {
        var path1 = event.data['path'];

        print(path1);
              // this path will be the location of messaage collection of reciver

        setState(() { 
         // path = Firestore.instance.collection(path1).snapshots();
         // path=  Firestore.instance.collection('$path1/chats').snapshots();
            message_path=path1;
            test(message_path);
          });
     
          
     
      } else {
         
      setState(() {
          path = Firestore.instance
            .collection(
                '/contacts/${widget.own_mobile}/group/${widget.id}/chats')
            .snapshots(); // usual query to thr messages/chats whatever it is, i.e own collection.
 
        // path = Firestore.instance
        //     .collection(
        //         '/1235/1235/message/${widget.id}/chats')
        //     .snapshots(); 

              message_path= '/contacts/${widget.own_mobile}/group/${widget.id}';
      test(message_path);
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///////   final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(7, 94, 84, 1),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(21, 137, 229, 1),
                      Color.fromRGBO(2, 205, 126, 1),
                    ],
                  ),
                ),
              ),
              title: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                       // 'https://media-exp1.licdn.com/dms/image/C5103AQHZZVDFPF0anQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Sea7OKWAI-o37VsOAr28879FhKCznJMxOef9zdFjbJ0'),
                      widget.appbarImage,),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                //    'Priyan Sir',
                  widget.appbarName,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    // stream: Firestore.instance
                    //     .collection(
                    //         '/${widget.own_mobile}/${widget.own_mobile}/message/${widget.id}/chats')
                    //     .snapshots(),
                    stream: path,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                          // _scrollToBottom(); 
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        
                          return new Text('Loading...');
                        default:
                        //callscroll();
                              //_scrollToBottom();
                          return new ListView(controller: _scrollcon,
                             //reverse: true, // _scrollToBottom();
                            children: snapshot.data.documents
                                .map((DocumentSnapshot doc) {
                              if (doc['sender'] ==
                                  int.parse('${widget.own_mobile}')) {
                                balignment = Alignment.topRight;
                                bnip = BubbleNip.rightTop;
                                bcolor = Color.fromRGBO(177, 255, 255, 1);
                                 btimestyle =
                                    TextStyle(color: Colors.grey, fontSize: 12);
                                btextstyle = TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15);
                                btextalign = TextAlign.right;
                                btimetextalign = TextAlign.left;
                                if (doc['delivered'] == true) {
                                  btimestyle = TextStyle(
                                      color: Colors.red, fontSize: 12);

                                  if (doc['seen'] == true) {
                                    btimestyle = TextStyle(
                                        color: Colors.green, fontSize: 12);
                                  }
                                }
                              } else {
                                balignment = Alignment.topLeft;
                                bnip = BubbleNip.leftTop;
                                bcolor = Colors.white;
                                btextstyle = TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15);
                                //   btextalign=TextAlign.right;
                                btimetextalign = TextAlign.left;
                                btimestyle =
                                    TextStyle(color: Colors.grey, fontSize: 12);
                              }

                              return Column(
                                children: <Widget>[
                                  Bubble(
                                      margin: BubbleEdges.only(top: 10),
                                      alignment: balignment,
                                      // nipWidth: 8,
                                      // nipHeight: 24,
                                      nip: bnip,
                                      color: bcolor,
                                      child: Column(
                                        children: <Widget>[
                                          Text(doc['message'],
                                              style: btextstyle,
                                              textAlign: btextalign),
                                          Text(
                                            doc['timestamp'],
                                            textAlign: TextAlign.left,
                                            style: btimestyle,
                                          ),
                                          //  Icon(Icons.check)
                                        ],
                                      )),
                                  //   Bubble(
                                  //       margin: BubbleEdges.only(top: 10),
                                  //       alignment: Alignment.topLeft,
                                  //       nip: BubbleNip.leftTop,
                                  //       child: Column(
                                  //         children: <Widget>[
                                  //           Text(
                                  //             'How are you?',
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.w600,
                                  //                 fontSize: 15),
                                  //           ),
                                  //           Text(
                                  //             '11.11 am',
                                  //             textAlign: TextAlign.left,
                                  //             style: TextStyle(
                                  //                 color: Colors.grey, fontSize: 12),
                                  //           ),
                                  //         ],
                                  //       )),
                                ],
                              );
                            }).toList(),
                          );
                      }
                    },
                  ),
                ),
                // expanded listview builder for messages 26.5.20 start
                // Expanded(
                //   child: ListView.builder(itemBuilder: (context, index) {
                //   return Column(
                //     children: <Widget>[
                //       Bubble(
                //           margin: BubbleEdges.only(top: 10),
                //           alignment: Alignment.topRight,
                //           nipWidth: 8,
                //           nipHeight: 24,
                //           nip: BubbleNip.rightTop,
                //           color: Color.fromRGBO(177, 255, 255, 1),
                //           child: Column(
                //             children: <Widget>[
                //               Text('Hi',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.w600,
                //                       fontSize: 15),
                //                   textAlign: TextAlign.right),
                //               Text(
                //                 '11.11 am',
                //                 textAlign: TextAlign.left,
                //                 style:
                //                     TextStyle(color: Colors.grey, fontSize: 12),
                //               ),
                //               //  Icon(Icons.check)
                //             ],
                //           )),
                //       Bubble(
                //           margin: BubbleEdges.only(top: 10),
                //           alignment: Alignment.topLeft,
                //           nip: BubbleNip.leftTop,
                //           child: Column(
                //             children: <Widget>[
                //               Text(
                //                 'How are you?',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w600, fontSize: 15),
                //               ),
                //               Text(
                //                 '11.11 am',
                //                 textAlign: TextAlign.left,
                //                 style:
                //                     TextStyle(color: Colors.grey, fontSize: 12),
                //               ),
                //             ],
                //           )),
                //     ],
                //   );
                // })),

//             // expanded listview builder for messages 26.5.20 end

                //websocket test start date 26.5.20
//                 StreamBuilder(
//                   stream: widget.channel.stream,
//                   builder: (context, snapshot) {
//                     return Bubble(
//                         margin: BubbleEdges.only(top: 10),
//                         alignment: Alignment.topRight,
//                         nipWidth: 8,
//                         nipHeight: 24,
//                         nip: BubbleNip.rightTop,
//                         color: Color.fromRGBO(225, 255, 199, 1.0),
//                         child: Column(
//                           children: <Widget>[
//                             Text('${snapshot.data}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600, fontSize: 15),
//                                 textAlign: TextAlign.right),
//                             Text(
//                               '11.11 am',
//                               textAlign: TextAlign.left,
//                               style:
//                                   TextStyle(color: Colors.grey, fontSize: 12),
//                             ),
//                             //  Icon(Icons.check)
//                           ],
//                         ));
//                   },
//                 ),
//  //websocket test ends date 26.5.20
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _controller,
                                    cursorColor: Colors.black26,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type here...',
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.photo_camera,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),

                    // RawMaterialButton(
                    //   onPressed: () {},
                    //   elevation: 2.0,
                    //   fillColor: Color.fromRGBO(0, 127, 123, 1),
                    //   child: Icon(
                    //     Icons.send,
                    //     color: Colors.white,
                    //     size: 20.0,
                    //   ),
                    //   padding: EdgeInsets.all(15.0),
                    //   shape: CircleBorder(),
                    // )

                    Container(
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.height / 11,
                        alignment: Alignment.center,
                        child: SizedBox(
                            child: FloatingActionButton(
                          backgroundColor: Color.fromRGBO(21, 137, 229, 1),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onPressed: () async {  

                            print('test');
                             _scrollToBottom();
                            print(path);
                            await messagepathdecider();
                             print(path);
                            if (_controller.text.isNotEmpty) {

                           //   _scrollToBottom();
                              //query to the respective path this is all to be done at the messages sending function

                              // Firestore.instance
                              //     .collection(
                              //         '/9993171180/9993171180/message/${widget.id}/chats')
                              //     .document('${Timestamp.now()}')
                              //     .setData({
                              //   'message': _controller.text,
                              //   'timestamp': '11:11',
                              //   'sender': int.parse('${widget.own_mobile}'),
                              //   'delivered': false,
                              //   'seen': false,
                              // });

                                var now = new DateTime.now();
                  var formatter = new DateFormat('dd-MM-yyyy');
                  String formattedTime = DateFormat('kk:mm:a').format(now);
                  String formattedDate = formatter.format(now);
                  print(formattedTime);
                  //print(formattedDate);
                  print(message_path);

                              Firestore.instance
                                  .collection('$message_path/chats')
                                  .document('${Timestamp.now()}')
                                  .setData({
                                'message': _controller.text,
                                'timestamp': '$formattedTime',
                                 'sender': int.parse('${widget.own_mobile}'),
                                //'sender': '${widget.own_mobile}',
                                'delivered': false,
                                'seen': false,
                              });
                           
                           _controller.clear();
                            }
                          },
                        ))),
                  ],
                ),
              ],
            )));
  }
}
