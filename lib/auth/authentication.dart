import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('$e');
      return null;
    }
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
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

  //stream the authentication status whether (signed in or signed out)

  Stream<User?> checkingAuthStatus() {
    return auth.authStateChanges();
  }
}
