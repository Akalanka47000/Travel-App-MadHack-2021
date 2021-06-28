import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/Helpers/CacheService.dart';
import 'package:travel_app/Models/UserModel.dart';

class Constants {
  static bool loggedInStatus;
  static UserModel user;


  void initializeUserData() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      loggedInStatus = true;
      user = UserModel(currentUser.uid,currentUser.displayName, currentUser.email);
    } else {
      loggedInStatus = false;
    }
  }
}
