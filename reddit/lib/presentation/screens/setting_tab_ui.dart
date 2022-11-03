import 'package:dartdoc/dartdoc.dart';
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(150, 10, 150, 0),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text(
              "User settings",
              style: TextStyle(color: Colors.black),
            ),
            bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Color.fromARGB(255, 28, 28, 28),
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
    );
  }
}
