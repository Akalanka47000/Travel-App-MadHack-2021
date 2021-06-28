import 'package:cloud_firestore/cloud_firestore.dart';
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

Future<String> registerUser(String email, String password, String name) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    await user.updateDisplayName(name);

    String creationProcess;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({
      'userID':user.uid,
      'username': name,
      'email': email,
    }).then((value) {
      creationProcess= "Success";
    }).catchError((error) {
      creationProcess= "An error has occurred. Please try again later";
    });
    return creationProcess;
  } on FirebaseAuthException catch (e) {
    String errorMsg = "An error has occurred. Please try again later";
    if (e.code == 'weak-password') {
      errorMsg = 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      errorMsg = 'The account already exists for that email';
    }
    return errorMsg;
  } catch (e) {
    print(e);
  }
}

Future<String> login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "Success";
  } on FirebaseAuthException catch (e) {
    String errorMsg = "An error has occurred. Please try again later";
    if (e.code == 'user-not-found') {
      errorMsg = 'No user found for that email';
    } else if (e.code == 'wrong-password') {
      errorMsg = 'Invalid password';
    }
    return errorMsg;
  }
}
