import 'package:flutter/material.dart';

class SettingTabUi extends StatefulWidget {
  const SettingTabUi({super.key});

  @override
  State<SettingTabUi> createState() => _SettingTabUiState();
}

class _SettingTabUiState extends State<SettingTabUi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(150, 10, 150, 0),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: const Text(
                "User settings",
                style: TextStyle(color: Colors.white),
              ),
              bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Color.fromARGB(255, 131, 122, 122),
                tabs: <Widget>[
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
