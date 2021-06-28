import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app/UI/Homescreen/HomeScreen.dart';

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
            child: Container(
              child: Stack(
                children: [
                  Transform.scale(
                    scale:1.4,
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitDualRing(
                          size: MediaQuery.of(context).size.width*0.35,
                          color: Colors.greenAccent,
                          lineWidth: 2,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GlowIcon(
                      Icons.airplanemode_active,
                      size: MediaQuery.of(context).size.width*0.35,
                      color: Colors.green,
                      blurRadius: 75,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
