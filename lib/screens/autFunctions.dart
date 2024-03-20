import 'package:firebase_auth/firebase_auth.dart';

signup(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print('/////// Success ////////');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<bool> signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    print('/////// Success ////////');

    // Return true indicating successful sign-in
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      // Return false for incorrect email/password
      return false;
    } else {
      // Handle other exceptions if needed
      print('Error during sign-in: $e');
      return false;
    }
  } catch (e) {
    print('Unexpected error during sign-in: $e');
    return false;
  }
}
