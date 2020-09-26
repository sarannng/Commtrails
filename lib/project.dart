import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:shah_messenger/project-detail.dart';

class Project extends StatefulWidget {
  Project({Key key}) : super(key: key);

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
children: <Widget>[
// 1st card start
  InkWell(
    onTap:  () {
       //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProjectDetails())); 

    },
child: Container(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(7, 94, 84, 0.7),
                    gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(21, 137, 229, 1),
                      Color.fromRGBO(2 , 205, 126, 1),
                    
                    
                    ],
                  ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Croptrails',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.white),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Deadline:',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          letterSpacing: 0.3,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '20:12:54',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          letterSpacing: 0.3,
                                          color: Colors.redAccent),
                                    )
                                  ],
                                ),
                                Divider(),
                                Text(
                                  'Team',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      letterSpacing: 0.3,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                       scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                           
                                          padding:
                                              EdgeInsets.fromLTRB(5,  0, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromRGBO(
                                                        64, 133, 156, 1),
                                                    shape: BoxShape.rectangle),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 16.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk"),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Sarang',
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                              // 1 TEAM MEMBER BOX
                                              ,
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromRGBO(
                                                        64, 133, 156, 1),
                                                    shape: BoxShape.rectangle),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 16,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://media-exp1.licdn.com/dms/image/C5103AQHZZVDFPF0anQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Sea7OKWAI-o37VsOAr28879FhKCznJMxOef9zdFjbJ0"),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Priyan S',
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromRGBO(
                                                        64, 133, 156, 1),
                                                    shape: BoxShape.rectangle),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 16,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://media-exp1.licdn.com/dms/image/C5603AQH00HKjsaxSXQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=1VF9_L-00jLnutvefsWhogG2TU6tn_agoZrTO-vhqUE"),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Dhruv S',
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                 
                                 SizedBox(height: 3,),
                               Container(
                                   padding: EdgeInsets.fromLTRB(15, 0, 15, 15) ,
                                 child:  Column(
                                   children: <Widget>[
                                   
                                     LinearProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),

                                 
                                 SizedBox(height: 5,),


                                Container(
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)

                                      
                                    ),
                                    child: Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )
                                   ],
                                 )
                                
                               )
                               
                              ],
                            )),
                      ))
                    ],
                  ),
                ),
              ),
   
  ) ,
// 1st card end

Divider(),
// 2st card start
  Container(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                  //  color: Color.fromRGBO(7, 94, 84, 0.7),
                     gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(21, 137, 229, 1),
                      Color.fromRGBO(2 , 205, 126, 1),
                    
                    
                    ],
                  ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '9Toyz',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.white),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Deadline:',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          letterSpacing: 0.3,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '15:32:10',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          letterSpacing: 0.3,
                                          color: Colors.redAccent),
                                    )
                                  ],
                                ),
                                Divider(),
                                Text(
                                  'Team',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      letterSpacing: 0.3,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                       scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                           
                                          padding:
                                              EdgeInsets.fromLTRB(5,  0, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromRGBO(
                                                        64, 133, 156, 1),
                                                    shape: BoxShape.rectangle),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 16.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk"),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Sarang',
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                              // 1 TEAM MEMBER BOX
                                              ,
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromRGBO(
                                                        64, 133, 156, 1),
                                                    shape: BoxShape.rectangle),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 16,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://media-exp1.licdn.com/dms/image/C5103AQHZZVDFPF0anQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Sea7OKWAI-o37VsOAr28879FhKCznJMxOef9zdFjbJ0"),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Priyan S',
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromRGBO(
                                                        64, 133, 156, 1),
                                                    shape: BoxShape.rectangle),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 16,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://media-exp1.licdn.com/dms/image/C5603AQH00HKjsaxSXQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=1VF9_L-00jLnutvefsWhogG2TU6tn_agoZrTO-vhqUE"),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Dhruv S',
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                 
                                 SizedBox(height: 3,),
                               Container(
                                   padding: EdgeInsets.fromLTRB(15, 0, 15, 15) ,
                                 child:  Column(
                                   children: <Widget>[
                                   
                                     LinearProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),

                                 
                                 SizedBox(height: 5,),


                                Container(
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)

                                      
                                    ),
                                    child: Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )
                                   ],
                                 )
                                
                               )
                               
                              ],
                            )),
                      ))
                    ],
                  ),
                ),
              ),
   
// 2st card end



],
              ) ;        }),
      ),
    );
  }
}
