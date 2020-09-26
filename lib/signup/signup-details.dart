import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remind_you/signup/onboard/login.dart';
import 'package:remind_you/tabbar.dart';

class SignupDetails extends StatefulWidget {
  final String phone;
  SignupDetails({Key key, this.phone}) : super(key: key);

  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {
  final name = TextEditingController();
  final number = TextEditingController();
  final post = TextEditingController();
  File _image;
  String dp;


  @override
  void initState() { 
    super.initState();
    setState(() {
       dp='https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
     print(dp);
    });
  }
  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = image;
    });

    print('dp from get image'+dp);
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Signup Details'),
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
            // Container(
            //   padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            //   child: TextField(
            //       controller: number,
            //     //keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       icon: Icon(Icons.phone_android),
            //       helperText: 'Mobile number',
            //     ),
            //   ),
            // ),
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
                        radius: 70,
                        backgroundImage: _image == null
                            ? NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')
                            : FileImage(_image, scale: 0.5)
                        // Image.file(
                        //     _image,

                        //   ),

                        ),
                    RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Upload Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          //_controller.clear();
                          getImage();
                        }),
                  ],
                )
              ],
            ),
            Divider(
              color: Colors.grey,
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
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
                    if (await uploadTask.onComplete != null && _image!= null) {
                      String url =
                          (await storageReference.getDownloadURL()).toString();
                      print(url);
                       showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert1;
                        },

                       );

                       print(name.text); 
                       if (_image==null) {
                        setState(() {
                          dp='https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
                        
                           print('dp from if'+ dp);
                        });
                       }

                       else{
                         setState(() {
                           dp=url;
                           print('dp from else'+ dp);
                         });
                       }
                    await Firestore.instance.collection('contacts').document('${widget.phone}')
                    // .collection('${number.text}')
                     //.document('${number.text}')
                    .setData({ 
                        'own_image':  dp,
                        'own_name' : '${name.text}',
                        // 'own_number': '91${number.text}',
                        // 'own_post': '${post.text}'

                      });

                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => Tabbar1()));
       }

       if(name.text!=null && _image==null){
         await Firestore.instance.collection('contacts').document('${widget.phone}')
                    // .collection('${number.text}')
                     //.document('${number.text}')
                    .setData({ 
                        'own_image':  dp,
                        'own_name' : '${name.text}',
                        // 'own_number': '91${number.text}',
                        // 'own_post': '${post.text}'

                      });

                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => Tabbar1()));
       }
                    //_controller.clear();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
