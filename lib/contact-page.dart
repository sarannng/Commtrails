import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_you/group/create_group.dart';
//import 'package:shah_messenger/message.dart';
//import 'package:web_socket_channel/io.dart';

class ContactPage extends StatefulWidget {
  final String ownMobile;
  ContactPage({Key key, this.ownMobile}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String own_mobile;
  List<bool> isSelected;

  @override
  void initState() {
    requestpermission(); 
    setownmobile();
    isSelected = [true, false];
    // getcontacts();
    super.initState();
  }

routeit(){
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GroupCreate())); 
                                   
}
  creatingGroup(){
    // v
  }
  setownmobile() {
    setState(() {
      own_mobile = widget.ownMobile;
    });
  }

  chatheadcreation(contact) {
    //    == 
    // print(contact.phones.first.value0
    //     .replaceAll(' ', '')
    //     .replaceAll('+', ''));
    var reciver = contact.phones.first.value 
        .replaceAll(' ', '')
        .replaceAll('+', '');
    var sender = '${widget.ownMobile}';

    print('this is num'+ sender);

    //getting recivers details.
    var rdata =
        //Firestore.instance.collection(reciver).document(reciver).snapshots();
        Firestore.instance.collection('contacts').document(reciver).snapshots();

    rdata.listen((event) async {
      var image = event.data['own_image'];
      var name = event.data['own_name'];
     // var post = event.data['own_post'];
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
     //   'sender_post': await post,
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
   //   var post = event.data['own_post'];
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
      //  'sender_post': post,
        'sender_number': number,
        'first': false,
        // 'path': ''
      });
    });

    //  setting own details to reciver ends.
  }

  requestpermission() async {
    if(await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('permission granted');
      getcontacts();
    }
  }

  getcontacts() async {
    print('in contact');
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
      print(contacts.length);
      print(contacts.map((e) => print(e.avatar)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),

            Text('Group', style: TextStyle(fontSize: 10),)
          ],
        ),
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GroupCreate(ownMobile: own_mobile))); 
                                   
      },),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(7, 94, 84, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  ' Contact List',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ' ${contacts.length} contacts',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ],
            ),

            //  ToggleButtons(
            //   borderColor: Colors.black,
            //   fillColor: Colors.grey,
            //   borderWidth: 2,
            //   selectedBorderColor: Colors.black,
            //   selectedColor: Colors.white,
            //   borderRadius: BorderRadius.circular(0),
            //   children: <Widget>[
            //       Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //           'Chat',
            //           style: TextStyle(fontSize: 16),
            //       ),
            //       ),
            //       Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //           'Group',
            //           style: TextStyle(fontSize: 16),
            //       ),
            //       ),
            //   ],
            //   onPressed: (int index) {
            //       setState(() {
            //       for (int i = 0; i < isSelected.length; i++) {
            //           isSelected[i] = i == index;
            //       }
            //       });
            //   },
            //   isSelected: isSelected,
            //   ),

            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      Container(
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          items:
                              <String>['Create Group', 'Help'].map((String value) {
                            return new DropdownMenuItem<String>(
                              onTap: () {
                                switch (value) {
                                  case 'Create Group':
                                      print('in');
                                     
                                    break;

                                  case 'Help':
                                    print('Help');

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
            )
          ],
        ),
      ),
      body: Container(
          child: Column(
        children: [
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
                              content: new Text('Chat has been added')));
                        Contact contact= Contact();
                          chatheadcreation(contact);
                              },
                              onTap: () {
                                print(doc.documentID);
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
                                    // Text(
                                    //   doc['own_post'],
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
            )),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'Contacts',
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
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = contacts[index];
                return Container(
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 10.0,
                      ),
                      ListTile(
                        
                        onTap:  () {
                          print(contact.phones.first.value);

                          //                    for(int i=0; i<contact.phones.first.value.length; i++){
                          //print(contact.phones.first.value[i]);

                          // String result1 = contact.phones.first.value
                          //     .replaceAll(' ', '')
                          //     .replaceAll('+', '');

                          //print(result1);

                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text('Chat has been added')));

                          chatheadcreation(contact);
//}
                        },
                        // onTap: () {
                        //   // _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        //   //     content: new Text('Chat has been added')));

                        //   // chatheadcreation(contact);
                        // },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              contact.displayName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                          ],
                        ),
                        // subtitle: Container(
                        //   padding: const EdgeInsets.only(top: 5.0),
                        //   child: Text(
                        //     contact.phones.elementAt(0).value,
                        //     style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        //   ),
                        // )
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )
          //

          // child: FutureBuilder(

          //   future:  ContactsService.getContacts()    ,
          //   builder: (context, value){
          //      if(value.hasError)
          //      return Text('Error:  ${value.error}');

          //      switch (value.connectionState) {
          //        case ConnectionState.waiting:
          //                 return Container(
          //                   height: MediaQuery.of(context).size.height,
          //                   width: MediaQuery.of(context).size.width,
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: <Widget>[
          //                       CircularProgressIndicator(),

          //                     ],
          //                   ),
          //                 );

          //        default:
          //       return  Container(
          //         child: Map,
          //       )

          //   }),

          // 27.05.20 dummy contact list

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

          //                 },
          //                 leading: CircleAvatar(
          //                   radius: 30,
          //                   backgroundImage: NetworkImage(
          //                       'https://media-exp1.licdn.com/dms/image/C5103AQHZZVDFPF0anQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Sea7OKWAI-o37VsOAr28879FhKCznJMxOef9zdFjbJ0'),
          //                 ),
          //                 title: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: <Widget>[
          //                     Text(
          //                       'Priyan Sir',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.w700, fontSize: 17),
          //                     ),

          //                   ],
          //                 ),
          //                 subtitle: Container(
          //                   padding: const EdgeInsets.only(top: 5.0),
          //                   child: Text(
          //                     'Cofounder CropTrails',
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
