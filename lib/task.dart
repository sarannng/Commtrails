import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task extends StatefulWidget {
  Task({Key key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
            child: Column(
          children: <Widget>[
            Divider(),

           
            Row(
              children: <Widget>[Container(
                padding: EdgeInsets.all(10),
                child: Text('Assigned Task : 2',
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),),
              )],
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                          ListTile( dense: true,
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:  Color.fromRGBO(21, 137, 229, 1),
                        child: Center(child: Text('CP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),),
                        // backgroundImage: NetworkImage(
                        //     'https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Fix bugs in app',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            '12:00 pm',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          'BY: Dhruv Sir',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),

                          Text(
                          'Deadline: 6:00pm',
                          style: TextStyle(color: Colors.redAccent, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                          ],
                        )
                      ),
                    ), 
                 
                           ListTile(
                             dense: true,
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:  Color.fromRGBO(21, 137, 229, 1),
                        child: Center(child: Text('9T', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),),
                        // backgroundImage: NetworkImage(
                        //     'https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Demo to clients',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            '2:00 pm',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          'BY: Priyan Sir',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),

                          Text(
                          'Deadline: Right Now ',
                          style: TextStyle(color: Colors.redAccent, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                          ],
                        )
                      ),
                    ),    

                      ],
                    ); }),
            ),
            
            
            ),

          ],
        ))
     ,
     //assigned task ends

        Expanded(
          flex: 1,
            child: Column(
          children: <Widget>[
            Divider(),

           
            Row(
              children: <Widget>[Container(
                padding: EdgeInsets.all(10),
                child: Text('Completed Task : 2',
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),),
              
              )],
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                          ListTile( dense: true,
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:  Color.fromRGBO(21, 137, 229, 1),
                        child: Center(child: Text('CP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),),
                        // backgroundImage: NetworkImage(
                        //     'https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Website 2nd module',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            '12:00 pm',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          'BY: Dhruv Sir',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),

                          Text(
                          'Deadline: 6:00pm',
                          style: TextStyle(color: Colors.redAccent, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                          ],
                        )
                      ),
                    ), 
                 
                           ListTile( dense: true,
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:  Color.fromRGBO(21, 137, 229, 1),
                        child: Center(child: Text('9T', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),),
                        // backgroundImage: NetworkImage(
                        //     'https://media-exp1.licdn.com/dms/image/C5603AQHtEUtA7KW-Jg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=yWhZk1SsqOUhFybv53CFCe9ZrgXMPdN49nT9N2hLxGk'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '9 Toyz app testing',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Text(
                            '2:00 pm',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                          'BY: Priyan Sir',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),

                          Text(
                          'Deadline: Right Now ',
                          style: TextStyle(color: Colors.redAccent, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                          ],
                        )
                      ),
                    ),    

                      ],
                    ); }),
            ),
            
            
            ),

          ],
        ))
     ,
     
     
      ],
    ));
  }
}
