import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remind_you/tabbar.dart';

class GroupCreate extends StatefulWidget {
  final String ownMobile;
  GroupCreate({Key key, this.ownMobile}) : super(key: key);

  @override
  _GroupCreateState createState() => _GroupCreateState();
}

class _GroupCreateState extends State<GroupCreate> {
  final name = TextEditingController();
  final number = TextEditingController();
  final post = TextEditingController();
  String _url;
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

      chatheadcreation1(contact) {
    //    == 
    // print(contact.phones.first.value0
    //     .replaceAll(' ', '')
    //     .replaceAll('+', ''));
    var reciver = contact.phones.first.value 
        .replaceAll(' ', '')
        .replaceAll('+', '');
    var sender = '${widget.ownMobile}';

    //getting recivers details.
    var rdata =
        //Firestore.instance.collection(reciver).document(reciver).snapshots();
        Firestore.instance.collection('contacts').document(reciver).snapshots();

    rdata.listen((event) async {
      var image = event.data['own_image'];
      var name = event.data['own_name'];
      var post = event.data['own_post'];
      var number = event.data['own_number'];

      // storing this details in sender chat section

      await Firestore.instance
          .collection('contacts')
          .document(sender)
          // .collection(sender)
          // .document(sender)
          .collection('message')
          .document(reciver)
          .setData({
        'sender_image': await image,
        'sender_name': await name,
        'sender_post': await post,
        'sender_number': await number,
        'first': true,
        'path': Firestore.instance
            .collection('contacts')
            .document(reciver)
            // .collection(reciver)
            // .document(reciver)
            .collection('message')
            .document(sender)
            .path
      });
    });

    // getting reciver details done.

    //starting setting own details to reciver
    var sdata = Firestore.instance
        .collection('contacts')
        .document(sender)
        // .collection(sender)
        // .document(sender)
        .snapshots();

    sdata.listen((event) {
      var image = event.data['own_image'];
      var name = event.data['own_name'];
      var post = event.data['own_post'];
      var number = event.data['own_number'];

      // storing this details in sender chat section

      Firestore.instance
          .collection('contacts')
          .document(reciver)
          // .collection(reciver)
          // .document(reciver)
          .collection('message')
          .document(sender)
          .setData({
        'sender_image': image,
        'sender_name': name,
        'sender_post': post,
        'sender_number': number,
        'first': false,
        // 'path': ''
      });
    });

    //  setting own details to reciver ends.
  }
  
  chatheadcreation(contact){
      var reciver = contact;
    var sender = '${widget.ownMobile}';

    print('sender reciver from chat section');
    print(sender);
    print(reciver);

    //sender setting up
  Firestore.instance.collection('contacts').document(sender).collection('group').document(name.text).setData({

       'group_image': _url,
      'group_name' : name.text,
      'group_status':number.text,
      'first': false,

          });

Firestore.instance.collection('contacts').document(reciver).collection('group').document(name.text).setData({
  'group_image': _url,
      'group_name' : name.text,
      'group_status':number.text,
      'first': true,
      'path': Firestore.instance.collection('contacts').document(sender).collection('group').document(name.text).collection('chats').path
 });
   
           

  }
  
  uploadImage() async {
       print(new DateTime.now().millisecondsSinceEpoch);
                    var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    final StorageReference storageReference =
                        FirebaseStorage.instance.ref().child('${number.text}$timestamp');

                    final StorageUploadTask uploadTask =
                        storageReference.putFile(_image);
                    // while (uploadTask.isInProgress) {
                    //   print('task in provess');
                    if (uploadTask.isInProgress) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                    // }
                    if (await uploadTask.onComplete != null) {
                      String url =
                          (await storageReference.getDownloadURL()).toString();
                      print(url);
                      setState(() {
                        _url=url;
                      });
                       showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert1;
                        },

                       );

      //                  print(name.text);
      //               await Firestore.instance.collection('contacts').document('91${number.text}')
      //               // .collection('${number.text}')
      //                //.document('${number.text}')
      //               .setData({ 
      //                   'own_image':   url,
      //                   'own_name' : '${name.text}',
      //                   'own_number': '91${number.text}',
      //                   'own_post': '${post.text}'

      //                 });

      //                 Navigator.of(context).popUntil((route) => route.isFirst);
      //                 Navigator.pushReplacement(
      // context, MaterialPageRoute(builder: (BuildContext context) => Tabbar1(ownMobile: '${number.text}',)));
       }
                    //_controller.clear();
                 
  }
  
  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = image;
    });
  }

  AlertDialog alert = AlertDialog(
    //title: Text("My title"),
    content: Row(
      children: [
        CircularProgressIndicator(),
      SizedBox(width: 20,),
        Text("Creating account...", style: TextStyle(fontWeight: FontWeight.w600),)
      ],
    ),
    actions: [],
  );

   AlertDialog alert1 = AlertDialog(
    //title: Text("My title"),
    content: Row(
      children: [
        Icon(Icons.sentiment_very_satisfied,color: Colors.blueGrey, ),
      SizedBox(width: 20,),
        Text("Welcome Aboard", style: TextStyle(fontWeight: FontWeight.w600),)
      ],
    ),
    actions: [],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Create Group'),
        centerTitle: true,
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
      ),
      body: Container(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: TextField(
                  controller: name,
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.person_add),
                  helperText: 'Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: TextField(
                  controller: number,
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android),
                  helperText: 'Status',
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            //   child: TextField(
            //       controller: post,
            //     //keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       icon: Icon(Icons.person_outline),
            //       helperText: 'Post',
            //     ),
            //   ),
            // ),
           
            Divider(
              color: Colors.grey,
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: _image == null
                            ? NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')
                            : FileImage(_image, scale: 0.5)
                        // Image.file(
                        //     _image,

                        //   ),

                        ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                        RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Select Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          //_controller.clear();
                          getImage();
                        }),
  SizedBox(width: 10,),
                          RaisedButton(
                        color: Colors.red[300],
                        child: Text(
                          'Upload Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          //_controller.clear();
                          uploadImage();
                          
                        })
                     ],
                   ),
                  ],
                )
              ],
            ),
            Divider(
              color: Colors.grey,
              height: 10,
            ),


             Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'Registered Contacts',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  // .collection('/9993171180/9993171180/message')
                  .collection('contacts')
                  //.orderBy('owner_name')
                  //  .collection('/+91 73898 39103/+91 73898 39103/message')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Container(
                        child: Center(
                            child: Column(
                      children: <Widget>[
                        Text(
                          'Contacts are loading...',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          strokeWidth: 5,
                        )
                      ],
                    )));
                  case ConnectionState.none:
                    return new Container(
                        child: Center(
                            child: Column(
                      children: <Widget>[
                        Text(
                          'Connection state none...',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                      children:
                          snapshot.data.documents.map((DocumentSnapshot doc) {
                        return Column(
                          children: <Widget>[
                            Divider(
                              height: 10.0,
                            ),
                            ListTile(
                              onLongPress: () {
                                 _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text('Added')));
                        Contact contact= Contact();
                          // chatheadcreation(contact);
                              },
                              onTap: () {
                                print(doc.documentID);
                                 chatheadcreation(doc.documentID);
                                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text('Added')));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) => Message(
                                //             id: doc.documentID,
                                //             own_mobile: own_mobile,
                                //             appbarImage: doc['sender_image'],
                                //             appbarName: doc['sender_name']
                                //             )));
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(doc['own_image']),
                                // backgroundImage: NetworkImage(doc['image']),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    doc['own_name'],
                                    //   doc['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      //color: namecolor
                                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      doc['own_post'],
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
            )),
          ),
         
            Container(
              padding: EdgeInsets.only(top: 25),
              child: RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                    'Create Group',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                  }),
            )
          ],
        ),
      ),
    );
  }
}
