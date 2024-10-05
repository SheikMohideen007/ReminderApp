import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('$e');
      return null;
    }
  }

  //signout
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('$e');
    }
  }
}
