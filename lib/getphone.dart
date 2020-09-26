import 'package:firebase_auth/firebase_auth.dart';

class GetPhone {
  String phonee;

  getphn() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    final phn = currentUser.phoneNumber;
    print('thissssssssssssssssssssssssssss');
    print(phn.toString());
    phonee = phn.toString();

    print('object');
    return phonee;
        
  }
}
