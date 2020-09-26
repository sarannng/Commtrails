import 'package:encrypt/encrypt.dart';

class Encrypt {
  encryption(String plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv); // THis will encrypt the text
 
    return encrypted.base64; // here we derive encrypted string from encrypted object 
                   // This will be stored in database  

  }

  decryption(String encrypted) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
                    //Here we fetch the encrypted string from database in String encrypted                                  
   Encrypted data= Encrypted.fromBase64(encrypted); // This converts the encrypted string into Encrypted object

    
    final decrypted = encrypter.decrypt(data, iv: iv); // Here our data gets finally decrypted in text form
    return decrypted;
  }
}
