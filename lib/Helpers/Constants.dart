import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/Helpers/CacheService.dart';
import 'package:travel_app/Models/UserModel.dart';

class Constants {
  static bool loggedInStatus;
  static String theme;
  static UserModel user;

  void initialize() async {
    theme = await CacheService.getTheme();
    if (theme == null || theme == "") {
      theme = "Dark";
    }
  }

  void initializeUserData() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      loggedInStatus = true;
      user = UserModel(currentUser.displayName, currentUser.email);
    } else {
      loggedInStatus = false;
    }
  }
}
