import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:travel_app/Services/authService.dart';
import 'package:travel_app/UI/Authentication/ConfirmationScreen.dart';
import 'package:travel_app/UI/Homescreen/Widgets/RoundedRectButton.dart';
import '../CustomWidgets/InputWidget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  var progress;

  final List<Color> signInGradients = [
    Color(0xFF0EDED2),
    Color(0xFF03A0FE),
  ];

  final List<Color> signUpGradients = [
    Color(0xFFFF9945),
    Color(0xFFFc6076),
  ];

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: Builder(
        builder: (context) {
          progress = ProgressHUD.of(context);
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1c1c1c),
                      Color(0xFF0d0d0d),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.7,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Logo.png"),
                          ),
                        ),
                      ),
                      InputWidget(0, 0, _emailController,false,"JohnDoe@example.com"),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Text(
                                  'Enter your email id to continue...',
                                  textAlign: TextAlign.center,
                                  style:
                                  TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_emailController.text != "") {
                            bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(_emailController.text);
                            if(emailValid){
                              progress.show();
                              bool emailExists =
                              await validateEmail(_emailController.text);
                              progress.dismiss();
                              if (emailExists) {
                                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => ConfirmationScreen(_emailController.text,"Login")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text(
                                      "Email not registered yet",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    "Invalid email format",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text(
                                  "Please enter an email to proceed",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: RoundedRectButton(
                            "Let's get Started", signInGradients, false),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_emailController.text != "") {
                            bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(_emailController.text);
                            if (emailValid) {
                              progress.show();
                              bool emailExists =
                              await validateEmail(_emailController.text);
                              progress.dismiss();
                              if (!emailExists) {
                                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => ConfirmationScreen(_emailController.text,"Register")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text(
                                      "Cannot register this email as it already exists",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    "Invalid email format",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text(
                                  "Please enter an email to proceed",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: RoundedRectButton(
                            "Create an Account", signUpGradients, false),
                      ),
                      SizedBox(
                        height: 50,
                      ),
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
