import 'package:flutter/material.dart';

class BottomDarkFooter extends StatelessWidget {
  const BottomDarkFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
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
            ),),
      ),
    );
  }
}
