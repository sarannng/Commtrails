import 'dart:async';
 
import 'dart:core';

import 'package:encrypt/encrypt.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//import 'package: flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class DatabaseManager{
Database _database;

Future opendb() async{
  //if(_database==null){
    print('opendb');
    _database= await openDatabase(
    join(await getDatabasesPath(), 'chat.db'),
    
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE chat(id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT)');
      print('in open db');
    
    },
    version: 1,
  );
  //}//
}

Future insertmessage(Chats chats) async {
  await opendb();
  return await _database.insert('chat', chats.toMap());
}

 Future<List<Chats>> getmessage() async{
   print(' before open db');
   await opendb();
   print(' after open db');
   
   final List<Map<String, dynamic>> maps=await _database.query('chat');
   return List.generate(maps.length, (i) {
     return Chats(
        id: maps[i]['id'],
        message: maps[i]['message'],
       );
   });
 }


 Future updatemessage(Chats chats)async{
   await opendb();
   return await _database.update('chat', chats.toMap(), where: 'id=?', whereArgs: [chats.id]);
 }

 Future deletemessaga(Chats chats ) async{
   await opendb();
   return await _database.delete('chat',where: 'id=?', whereArgs: [chats.id]);
 }
}

class Chats{
  int id;
  //List<int> message;
  Encrypted message;

  Chats({ this.id, this.message,} );

  Map<String , dynamic>toMap(){
      return{
        'id':id,
        'message': message,
      };
  }
}