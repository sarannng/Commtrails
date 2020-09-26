import 'package:encrypt/encrypt.dart';

void main() {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
    String encrypted1=encrypted.base64;

                Encrypted e2= Encrypted.fromBase64(encrypted1);     

  final decrypted1 = encrypter.decrypt(e2, iv: iv);   
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
 
  print(decrypted1);
  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
}


// import 'package:crypto/crypto.dart';
// import 'dart:convert'; // for the utf8.encode method

// void main() {
//   var bytes = utf8.encode("foobar"); // data being hashed
//   print(bytes.length);
//   print(bytes);
//               print(  utf8.decode(bytes));



//   // var digest = sha1.convert(bytes);
               

//   // print("Digest as bytes: ${digest.bytes}");
//   // print("Digest as hex string: $digest");
// }