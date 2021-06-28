import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_app/UI/Homescreen/HomeScreen.dart';

import 'CustomWidgets/LoadingIndicator.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation =
                    CurvedAnimation(parent: animation, curve: Curves.easeOut);
                return ScaleTransition(
                  alignment: Alignment.center,
                  scale: animation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secAnimation) {
                return HomeScreen();
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            //Color(0xFF0d0d0d),
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end:Alignment.bottomCenter,
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              MediaQuery.of(context).size.height * 0.02,
            ),
            child: LoadingIndicator()
          ),
        ],
      ),
    );
  }
}
