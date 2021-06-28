import 'package:firebase_auth/firebase_auth.dart';

Future<bool> validateEmail(String email) async {
  bool status;
  await FirebaseAuth.instance.fetchSignInMethodsForEmail(email).then((value) {
    if (value.isEmpty) {
      status = false;
    } else {
      status = true;
    }
  });
  return status;
}

Future<String> registerUser(String email, String password,String name) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    await user.updateDisplayName(name);
    return "Success";
  } on FirebaseAuthException catch (e) {
    String errorMsg;
    if (e.code == 'weak-password') {
      errorMsg='The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      errorMsg='The account already exists for that email';
    }
    return errorMsg;
  } catch (e) {
    print(e);
  }
}


Future<String> login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return "Success";
  } on FirebaseAuthException catch (e) {
    String errorMsg;
    if (e.code == 'user-not-found') {
      errorMsg='No user found for that email';
    } else if (e.code == 'wrong-password') {
      errorMsg='Invalid password';
    }
    return errorMsg;
  }
}


