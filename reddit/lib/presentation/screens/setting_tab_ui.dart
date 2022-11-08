import 'package:flutter/material.dart';

class SettingTabUi extends StatefulWidget {
  const SettingTabUi({super.key});

  @override
  State<SettingTabUi> createState() => _SettingTabUiState();
}

class _SettingTabUiState extends State<SettingTabUi> {
  var whiteColor = Colors.white;
  var blackColor = Colors.black;

  ///Its value changes according to Application Mode.
  ///
  ///Default is Light Mode.
  late var labelColor = blackColor;

  ///Its value changes according to Application Mode.
  ///
  ///Default is Light Mode.
  late var backgroundColor = whiteColor;

  ///Changing the dark mode to light mode versa.
  void switchMode() {
    if (backgroundColor == blackColor) {
      labelColor = blackColor;
      backgroundColor = whiteColor;
    } else {
      labelColor = whiteColor;
      backgroundColor = blackColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(150, 10, 150, 0),
          child: Scaffold(
            // ///For testing switching between modes only.
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => setState(() {
            //     switchMode();
            //   }),
            // ),
            backgroundColor: backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              title: Text(
                "User settings",
                style: TextStyle(color: labelColor),
              ),
              bottom: TabBar(
                labelColor: labelColor,
                unselectedLabelColor: const Color.fromARGB(255, 131, 122, 122),
                tabs: const <Widget>[
                  Tab(
                    child: Text("Account"),
                  ),
                  Tab(
                    child: Text("Profile"),
                  ),
                  Tab(
                    child: Text("Safety and privacy"),
                  ),
                  Tab(
                    child: Text("Feed Settings"),
                  ),
                  Tab(
                    child: Text("Email"),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}
