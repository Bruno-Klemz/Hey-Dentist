import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signIn({required String email, required String password}) async {
    try {
      UserCredential _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: 'klemz.bruno@gmail.com', password: 'Coritiba1998');
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> registerWithEmail(String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
