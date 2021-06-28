import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedRectButton extends StatelessWidget {
  RoundedRectButton(this.title, this.gradient);
  final String title;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  color: gradient[0].withOpacity(0.4),
                  blurRadius: 85,
                  spreadRadius: 0)
            ]),
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        padding: EdgeInsets.only(top: 16, bottom: 16),
      ),
    );
  }
}
