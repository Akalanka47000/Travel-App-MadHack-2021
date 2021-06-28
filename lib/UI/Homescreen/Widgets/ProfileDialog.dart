import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Helpers/Constants.dart';


class ProfileDialog extends StatelessWidget {
  ProfileDialog(this.name, this.email);

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor:  Color(0xFF080808) ,
          content: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.95 : MediaQuery.of(context).size.width * 0.5,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, MediaQuery.of(context).size.height * 0.03),
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
                          radius: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.height * 0.08,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.blue.withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2),
                          ],
                        ),
                        height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.05 : MediaQuery.of(context).size.height * 0.09,
                        child: Padding(
                          padding: MediaQuery.of(context).orientation == Orientation.portrait
                              ? EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, MediaQuery.of(context).size.width * 0.02, MediaQuery.of(context).size.width * 0.04,
                              MediaQuery.of(context).size.width * 0.02)
                              : EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.07 : MediaQuery.of(context).size.height * 0.07,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text(
                                Constants.user.username,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.blue.withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2),
                          ],
                        ),
                        height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.05 : MediaQuery.of(context).size.height * 0.09,
                        child: Padding(
                          padding: MediaQuery.of(context).orientation == Orientation.portrait
                              ? EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, MediaQuery.of(context).size.width * 0.02, MediaQuery.of(context).size.width * 0.04,
                              MediaQuery.of(context).size.width * 0.02)
                              : EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.06 : MediaQuery.of(context).size.height * 0.07,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text(
                                Constants.user.email,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
