import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/Models/DestinationModel.dart';

Future<List<DestinationModel>> getDestinations(String menuOption) async {
  try {
    var currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot queryResults;
    if (menuOption == "Explore") {
      //get all destinations
      queryResults = await FirebaseFirestore.instance.collection('destinations').orderBy('date', descending: false).get().then((QuerySnapshot querySnapshot) {
        return querySnapshot;
      });
    } else if (menuOption == "To Visit") {
      //get destinations where user is in attendee list
      if(currentUser!=null){
        queryResults =
        await FirebaseFirestore.instance.collection('destinations').where("attendees", arrayContains: currentUser.uid).orderBy('date', descending: false).get().then((QuerySnapshot querySnapshot) {
          return querySnapshot;
        });
      }
    } else {
      //get destinations where user is in attendee list and is over
      if(currentUser!=null){
        queryResults = await FirebaseFirestore.instance
            .collection('destinations')
            .where("attendees", arrayContains: currentUser.uid)
            .where("date", isGreaterThanOrEqualTo: DateTime.now())
            .orderBy('date', descending: false)
            .get()
            .then((QuerySnapshot querySnapshot) {
          return querySnapshot;
        });
      }
    }
    if(queryResults!=null){
      List<DestinationModel> _destinations = queryResults.docs.map((json) => DestinationModel.fromJson(json.data())).toList();
      return _destinations;
    }else{
      return [];
    }

  } catch (e) {
    print(e);
  }
}

Future<DestinationModel> getSingleDestination(String destinationID) async {
  try {
    return FirebaseFirestore.instance.collection('destinations').doc(destinationID).get().then((DocumentSnapshot document) {
      return DestinationModel.fromJson(document.data());
    });
  } catch (e) {
    print(e);
  }
}

Future<String> updateDestinationAttendeeList(String destinationID, String userID, List<dynamic> attendees, String action) async {
  if (action == "Add") {
    attendees.add(userID);
  } else {
    attendees.remove(userID);
  }

  return await FirebaseFirestore.instance.collection('destinations').doc(destinationID).update({'attendees': attendees}).then((value) {
    return "Success";
  }).catchError((error) {
    return "An error has occurred. Please try again later";
  });
}
