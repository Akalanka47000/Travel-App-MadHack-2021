import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future getDestinations(String menuOption) async {
  var currentUser = FirebaseAuth.instance.currentUser;

  if (menuOption == "Explore") {
    //get all destinations
    return FirebaseFirestore.instance.collection('destinations').orderBy('date',descending: false).get().then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });
  } else if (menuOption == "To Visit") {
    //get destinations where user is in attendee list
    return FirebaseFirestore.instance.collection('destinations').where("attendees", arrayContains: currentUser.uid).orderBy('date',descending: false).get().then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });
  } else {
    //get destinations where user is in attendee list and is over
    return FirebaseFirestore.instance
        .collection('destinations')
        .where("attendees", arrayContains: currentUser.uid)
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('date',descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });
  }
}
