import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Helpers/Constants.dart';

class DefaultCard extends StatelessWidget {
  DefaultCard(this.icon, this.text);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.5,
              width:MediaQuery.of(context).size.width * 0.8  ,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.blue.withAlpha(100), offset: Offset(1, 4), blurRadius: 8, spreadRadius: 2),
                ],
                //gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.height * 0.3,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.06, 10, MediaQuery.of(context).size.width * 0.06, 0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          height: 1.5,
                          fontSize: 15,
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
      ],
    );
  }
}
