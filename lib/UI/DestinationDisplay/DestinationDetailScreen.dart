import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Helpers/Constants.dart';
import 'package:travel_app/Models/DestinationModel.dart';
import 'package:travel_app/Services/travelService.dart';
import 'package:travel_app/UI/CustomWidgets/ImageDisplay.dart';
import 'package:travel_app/UI/CustomWidgets/LoadingIndicator.dart';
import 'package:travel_app/UI/DestinationDisplay/Widgets/DestinationImage.dart';

import 'Widgets/BG.dart';

class DestinationDetailScreen extends StatefulWidget {
  const DestinationDetailScreen(this.destinationID, this.destinationName);
  final String destinationID;
  final String destinationName;

  @override
  _DestinationDetailScreenState createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  var progress;

  buildTableRow(String identifier, String value) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1)),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            identifier,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) {
          final progress = ProgressHUD.of(context);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    offset: Offset(0, 0),
                  ),
                ]),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black,
                  automaticallyImplyLeading: false,
                  title: Center(
                    child: Text(
                      widget.destinationName,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                BG(),
                FutureBuilder<DestinationModel>(
                  future: getSingleDestination(widget.destinationID),
                  builder: (BuildContext context, AsyncSnapshot<DestinationModel> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.04, MediaQuery.of(context).size.width * 0.05, 0),
                            child: Container(
                              height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.25 : MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.92,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  spreadRadius: 0.7,
                                  offset: Offset(0, 1),
                                )
                              ]),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => ImageDisplay(snapshot.data.imageURL),
                                    ),
                                  );
                                },
                                child: DestinationImage(snapshot.data.imageURL),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height * 0.03, 30, MediaQuery.of(context).size.height * 0.02),
                              child: Text(
                                snapshot.data.description,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.03, MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.04),
                            child: Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                buildTableRow("Event Date", snapshot.data.date.toDate().toString().substring(0, 11)),
                                buildTableRow("Time", snapshot.data.date.toDate().toString().substring(11, 16)),
                                buildTableRow("Capacity", "${snapshot.data.attendees.length}/${snapshot.data.capacity} People"),
                                buildTableRow("Contact", snapshot.data.contact),
                              ],
                            ),
                          ),
                          //Button
                          snapshot.data.date.toDate().isBefore(DateTime.now())
                              ? InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text("This feature is disabled as the tour is already over"),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.02, MediaQuery.of(context).size.width * 0.05,
                                        MediaQuery.of(context).size.height * 0.05),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[700],
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(color: Colors.grey[700].withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2),
                                        ],
                                        //gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])
                                      ),
                                      child: Text(
                                        Constants.user==null?"Reserve Spot":(snapshot.data.attendees.contains(Constants.user.userID) ? "Leave" : "Reserve Spot"),
                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    if(Constants.user==null){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.redAccent,
                                          content: Text(
                                            "You need to be signed in to reserve a spot",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }else{
                                      if (!snapshot.data.attendees.contains(Constants.user.userID)) {
                                        if (snapshot.data.attendees.length < snapshot.data.capacity) {
                                          progress.show();
                                          String message = await updateDestinationAttendeeList(widget.destinationID,Constants.user.userID,snapshot.data.attendees,"Add");
                                          progress.dismiss();
                                          if (message == "Success") {
                                            setState(() {});
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.greenAccent,
                                                content: Text(
                                                  "Reserved spot on tour successfully",
                                                  style: TextStyle(
                                                    color: Colors.black.withOpacity(0.65),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.redAccent,
                                                content: Text(
                                                  "An error has occurred. Please try again later",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.redAccent,
                                              content: Text(
                                                "This expedition is at full capacity",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        progress.show();
                                        String message = await updateDestinationAttendeeList(widget.destinationID,Constants.user.userID,snapshot.data.attendees,"remove");
                                        progress.dismiss();
                                        if (message == "Success") {
                                          setState(() {});
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.greenAccent,
                                              content: Text(
                                                "Unsubscribed from tour successfully",
                                                style: TextStyle(
                                                  color: Colors.black.withOpacity(0.65),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.redAccent,
                                              content: Text(
                                                "An error has occurred. Please try again later",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.02, MediaQuery.of(context).size.width * 0.05,
                                        MediaQuery.of(context).size.height * 0.05),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(color: Colors.deepOrange.withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2),
                                        ],
                                        //gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])
                                      ),
                                      child: Text(
                                        Constants.user==null?"Reserve Spot":(snapshot.data.attendees.contains(Constants.user.userID) ? "Leave" : "Reserve Spot"),
                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    } else {
                      return LoadingIndicator();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
