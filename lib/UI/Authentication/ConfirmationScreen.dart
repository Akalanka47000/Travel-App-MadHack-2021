import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:travel_app/Helpers/Constants.dart';
import 'package:travel_app/Services/authService.dart';
import 'package:travel_app/UI/Authentication/LoginScreen.dart';
import 'package:travel_app/UI/CustomWidgets/Background.dart';
import 'package:travel_app/UI/Homescreen/HomeScreen.dart';
import 'package:travel_app/UI/CustomWidgets/RoundedRectButton.dart';
import '../CustomWidgets/InputWidget.dart';

class ConfirmationScreen extends StatefulWidget {
  ConfirmationScreen(this.email, this.action);
  final String email;
  final String action;

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var progress;

  final List<Color> signInGradients = [
    Color(0xFF0EDED2),
    Color(0xFF03A0FE),
  ];

  final List<Color> signUpGradients = [
    Color(0xFFFF9945),
    Color(0xFFFc6076),
  ];

  void handleLogin() async {
    if (_passwordController.text != "") {
      progress.show();
      String loginResult= await login(widget.email, _passwordController.text);
      progress.dismiss();
      if(loginResult=="Success"){
        Constants().initializeUserData();
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              loginResult,
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
            "Please enter a password",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void handleRegister() async {
    if (_nameController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Please enter a name",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if (_passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Please enter a password",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      progress.show();
      String registrationResult= await registerUser(widget.email, _passwordController.text,_nameController.text);
      progress.dismiss();
      if(registrationResult=="Success"){
        Constants().initializeUserData();
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              registrationResult,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  Future<bool> onBackPressed() {
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: ProgressHUD(
        child: Builder(builder: (context) {
          progress = ProgressHUD.of(context);
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1c1c1c),
                          Color(0xFF0d0d0d),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                ),
               // Background(),
                Center(
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
                        SizedBox(
                          height: 20,
                        ),
                        widget.action == "Register"
                            ? Column(
                                children: [
                                  InputWidget(
                                      0, 0, _nameController, false, "John Doe"),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Text(
                                          'Enter name...',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFFA0A0A0),
                                              fontSize: 12),
                                        ),
                                      )),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                        InputWidget(0, 0, _passwordController, true, ""),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Enter password...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFFA0A0A0), fontSize: 12),
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () async {
                            if (widget.action == "Login") {
                              handleLogin();
                            } else {
                              handleRegister();
                            }
                          },
                          child: RoundedRectButton(
                            widget.action == "Login" ? "Login" : "Create Account",
                            signUpGradients,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
