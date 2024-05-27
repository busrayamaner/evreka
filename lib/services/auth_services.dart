import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future<UserCredential?> loginApp(
      {required String email, required String password}) async {
    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
}
