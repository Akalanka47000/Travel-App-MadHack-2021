import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  InputWidget(this.topRight, this.bottomRight, this.controller, this.obscureText, this.hintText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white24,
                blurRadius: 85,
                spreadRadius: 0
            )
          ]
      ),
      child: Material(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(15),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
            ),
          ),
        ),
      ),
    );
  }
}
