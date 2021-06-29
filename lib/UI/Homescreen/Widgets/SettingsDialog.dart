import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Helpers/CacheService.dart';
import 'package:travel_app/Helpers/Constants.dart';
import 'package:travel_app/Models/CustomWidgetModels/MenuItemModel.dart';

import '../../Authentication/LoginScreen.dart';

class SettingsDialog extends StatefulWidget {
  SettingsDialog(this.refreshFunction);
  final VoidCallback refreshFunction;

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
            icon: Constants.loggedInStatus ? Icons.logout : Icons.login,
            itemName: Constants.loggedInStatus ? "Sign Out" : "Sign In",
            color: Colors.blue),
      ];
      return Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? 140
            : MediaQuery.of(context).size.height * 0.32 * (menuItems.length),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          gradient: new LinearGradient(
            colors: [Colors.black.withOpacity(0.95), Colors.black]
               ,
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
                      Colors.white ,
                  boxShadow: [
                    BoxShadow(
                      color:  Colors.white10
                         ,
                      spreadRadius:3 ,
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
                      if (menuItem == "Sign Out") {
                        await FirebaseAuth.instance.signOut();
                        Constants.user = null;
                        Constants.loggedInStatus = false;
                        widget.refreshFunction();
                        Navigator.of(context).pop();
                      } else if (menuItem == "Sign In") {
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
                              color: Colors.white10
                                ,
                              spreadRadius: 3 ,
                              blurRadius: 2,
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
                          color: Colors.white
                             ,
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
