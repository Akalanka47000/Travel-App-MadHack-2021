import 'package:flutter/material.dart';
class DetailPageButton extends StatelessWidget {
  const DetailPageButton(this.text, this.color, this.topPadding, this.bottomPadding);
  final String text;
  final Color color;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height*topPadding, MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.height*bottomPadding),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: color.withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2),
          ],
          //gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
