import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Helpers/CacheService.dart';
import 'package:travel_app/Helpers/Constants.dart';
import 'package:travel_app/Models/CustomWidgetModels/MenuItemModel.dart';

import '../../Authentication/LoginScreen.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  List<MenuItems> menuItems;

//callback to update the state of the screen
  void setStateCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      //Menu item list which is displayed when settings button is clicked
      menuItems = [
        MenuItems(
            icon: Icons.color_lens,
            itemName: "Change Theme [${Constants.theme}]",
            color: Colors.blue),
        MenuItems(
            icon: Constants.loggedInStatus ? Icons.logout : Icons.login,
            itemName: Constants.loggedInStatus ? "Logout" : "Sign In",
            color: Colors.blue),
      ];
      return Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? 210
            : MediaQuery.of(context).size.height * 0.32 * (menuItems.length),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          gradient: new LinearGradient(
            colors: Constants.theme == "Dark"
                ? [Colors.black.withOpacity(0.95), Colors.black]
                : [Colors.black.withOpacity(0), Colors.black.withOpacity(0.2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color:
                      Constants.theme == "Dark" ? Colors.white : Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Constants.theme == "Dark"
                          ? Colors.white10
                          : Colors.black26,
                      spreadRadius: Constants.theme == "Dark" ? 3 : 1,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              itemCount: menuItems.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      String menuItem = menuItems[index].itemName;
                      if (menuItem == "Logout") {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                        setState(() {});
                      } else if (menuItem == "Sign In") {
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      } else if (menuItem ==
                          "Change Theme [${Constants.theme}]") {
                        if (Constants.theme == "Dark") {
                          Constants.theme = "Light";
                          CacheService.setTheme("Light");
                        } else {
                          Constants.theme = "Dark";
                          CacheService.setTheme("Dark");
                        }
                        setState(() {
                          print("Theme Changed");
                        });
                        setStateCallback();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: menuItems[index].color.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Constants.theme == "Dark"
                                  ? Colors.white10
                                  : Colors.black.withOpacity(0.15),
                              spreadRadius: Constants.theme == "Dark" ? 3 : 1,
                              blurRadius: Constants.theme == "Dark" ? 2 : 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.width * 0.1
                            : MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.width * 0.1
                            : MediaQuery.of(context).size.width * 0.05,
                        child: Icon(
                          menuItems[index].icon,
                          size: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.width * 0.06
                              : MediaQuery.of(context).size.width * 0.035,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        menuItems[index].itemName,
                        style: TextStyle(
                          color: Constants.theme == "Dark"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
