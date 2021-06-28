import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Helpers/CacheService.dart';
import 'package:travel_app/Helpers/Constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:travel_app/Models/Enums.dart';
import 'package:travel_app/UI/DestinationDisplay/DestinationList.dart';
import 'package:travel_app/UI/Homescreen/Widgets/ProfileDialog.dart';
import 'package:travel_app/UI/Homescreen/Widgets/SettingsDialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  HomeScreen();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _settingsButtonRotationController;
  Future myFuture;

  var progress;

  List menuOptions = [
    "Explore",
    "To Visit",
    "Visited",
  ];

  @override
  void initState() {
    super.initState();
    _settingsButtonRotationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _settingsButtonRotationController.dispose();
  }

  getSearchResults(String pattern, dynamic countryList) {
    print("Searching");
    List<dynamic> searchResults = List();
    for (dynamic country in countryList) {
      if (country["Country"].toUpperCase() == pattern.toUpperCase() || (pattern.length >= 3 && country["Country"].toUpperCase().toString().contains(pattern.toUpperCase()))) {
        searchResults.add(country);
      }
    }
    return searchResults;
  }

  void refreshState() {
    setState(() {});
  }

  Future<bool> onBackPressed() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: ProgressHUD(
        child: Builder(
          builder: (context) {
            progress = ProgressHUD.of(context);
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius:  6.0 ,
                        offset: Offset(0, 0),
                      ),
                    ]),
                    child: AppBar(
                      elevation: 0,
                      backgroundColor:Colors.black ,
                      shadowColor: Colors.black,
                      automaticallyImplyLeading: false,
                      title: Stack(
                        alignment: AlignmentDirectional.center,
                        fit: StackFit.loose,
                        children: [
                          Center(
                            child: Text(
                              "Travel App",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  color:Colors.white ,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Constants.loggedInStatus
                                  ? InkWell(
                                      onTap: () async {
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return ProfileDialog("Name", "Email");
                                                },
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 6),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white10,
                                                spreadRadius: 3,
                                                blurRadius: 2,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundImage: AssetImage('assets/images/profile.png'),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    _settingsButtonRotationController.forward();
                                    Future.delayed(Duration(milliseconds: 1000), () {
                                      _settingsButtonRotationController.reset();
                                    });
                                    return showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return SettingsDialog(refreshState);
                                        });
                                  },
                                  child: RotationTransition(
                                    turns: Tween(begin: 0.0, end: 1.0).animate(_settingsButtonRotationController),
                                    child: Icon(
                                      Icons.settings,
                                      size: 28,
                                      color:  Colors.redAccent ,
                                    ),
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
                    Positioned(
                      top: 0,
                      child: Transform.scale(
                        scale: 1.1,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/travel.gif"),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Container(
                            child: CarouselSlider.builder(
                              carouselController: CarouselController(),
                              itemCount: menuOptions.length,
                              itemBuilder: (BuildContext context, int itemIndex) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (menuOptions[itemIndex] == "Explore") {
                                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => DestinationList("Explore")));
                                    } else if (menuOptions[itemIndex] == "To Visit") {
                                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => DestinationList("To Visit")));
                                    } else {
                                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => DestinationList("Visited")));
                                    }

                                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => PracticePage(cameras:cameras,title: "posenet")));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                          Colors.black,
                                          Color(0xFF000217).withOpacity(0.8),
                                        ], stops: [
                                          0.3,
                                          1
                                        ]),
                                        borderRadius: BorderRadius.circular(30.0),
                                        boxShadow: <BoxShadow>[
                                          //BoxShadow(color: Colors.black.withAlpha(100), offset: Offset(0, 0), blurRadius: 8, spreadRadius: 5),
                                          BoxShadow(color: Colors.black.withAlpha(100), offset: Offset(0, 0), blurRadius: 6, spreadRadius: 3),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Image(
                                                image: AssetImage("assets/images/${menuOptions[itemIndex]}.png"),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              child: Text(
                                                menuOptions[itemIndex],
                                                style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * 0.3,
                                aspectRatio: 1,
                                reverse: false,
                                autoPlay: true,
                                initialPage: 0,
                                autoPlayInterval: Duration(seconds: 4),
                                autoPlayAnimationDuration: const Duration(seconds: 4),
                                scrollDirection: Axis.horizontal,
                                scrollPhysics: AlwaysScrollableScrollPhysics(),
                                pauseAutoPlayOnManualNavigate: true,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {},
                                viewportFraction: 0.55,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
