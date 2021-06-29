import 'package:flutter/material.dart';

class BG extends StatelessWidget {
  const BG({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0a0a0a),
              Color(0xFF0d0d0d),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );
  }
}
