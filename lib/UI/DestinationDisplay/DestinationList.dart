import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Models/DestinationModel.dart';
import 'package:travel_app/Services/travelService.dart';
import 'package:travel_app/UI/CustomWidgets/DefaultCard.dart';
import 'package:travel_app/UI/CustomWidgets/GlowText.dart';
import 'package:travel_app/UI/CustomWidgets/LoadingIndicator.dart';
import 'package:travel_app/UI/DestinationDisplay/Widgets/DestinationImage.dart';
import 'package:travel_app/UI/DestinationDisplay/Widgets/Search.dart';
import 'dart:async';
import 'package:travel_app/UI/Homescreen/HomeScreen.dart';

import 'DestinationDetailScreen.dart';
import 'Widgets/BG.dart';

class DestinationList extends StatefulWidget {
  DestinationList(this.menuOption);
  final String menuOption;
  @override
  _DestinationList createState() => _DestinationList();
}

class _DestinationList extends State<DestinationList> with TickerProviderStateMixin {
  bool searchClicked = false;

  TextEditingController _searchController = TextEditingController();
  AnimationController _searchBoxFadeController;
  Animation _searchBoxAnimation;

  Color searchIconColor;

  @override
  void initState() {
    super.initState();
    _searchBoxFadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _searchBoxAnimation = CurvedAnimation(
      parent: _searchBoxFadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _searchBoxFadeController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext mainContext) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
              title: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.loose,
                children: [
                  Center(
                    child: Text(
                      widget.menuOption,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (searchClicked) {
                                searchClicked = false;
                                _searchBoxFadeController.reverse();
                                _searchController.clear();
                              } else {
                                searchClicked = true;
                                _searchBoxFadeController.forward();
                              }
                            });
                          },
                          child: Icon(
                            Icons.search,
                            size: 28,
                            color: searchClicked ? Colors.redAccent : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            BG(),
            FutureBuilder<List<DestinationModel>>(
              future: getDestinations(widget.menuOption),
              builder: (BuildContext context, AsyncSnapshot<List<DestinationModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return DefaultCard(
                      Icons.hourglass_empty,
                      widget.menuOption == "Explore"
                          ? "No travel destinations available yet"
                          : (widget.menuOption == "To Visit" ? "You have not picked any destination to visit yet" : "You have not visited any destination yet"),
                    );
                  } else {
                    return Stack(
                      children: [
                        ListView.builder(
                          itemCount: snapshot.data.length + 1,
                          itemBuilder: (context, index) {
                            if (index == snapshot.data.length) {
                              return SizedBox(height: 80);
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => DestinationDetailScreen(snapshot.data[index].id, snapshot.data[index].name),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Column(
                                    children: [
                                      DestinationImage(snapshot.data[index].imageURL),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.008, 0, 0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.07,
                                            ),
                                            GlowText(snapshot.data[index].name, 16),
                                            Spacer(),
                                            widget.menuOption == "To Visit"
                                                ? Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.07, 0),
                                                    child: GlowText(snapshot.data[index].date.toDate().toString().substring(0, 11), 16),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.8),
                                      Colors.black.withOpacity(1),
                                    ],
                                    stops: [
                                      0.0,
                                      0.5,
                                      0.8,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                )),
                          ),
                        ),
                        Search(searchClicked, _searchController, _searchBoxAnimation, snapshot.data),
                      ],
                    );
                  }
                } else {
                  return LoadingIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
