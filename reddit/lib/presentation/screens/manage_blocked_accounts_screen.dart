import 'package:flutter/material.dart';

class ManageBlockedAccountsScreen extends StatefulWidget {
  const ManageBlockedAccountsScreen({Key? key}) : super(key: key);

  @override
  State<ManageBlockedAccountsScreen> createState() =>
      _ManageBlockedAccountsScreenState();
}

class _ManageBlockedAccountsScreenState
    extends State<ManageBlockedAccountsScreen> {
  final _blockNewAccountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blocked accounts"),
        centerTitle: true,
      ),
      // TODO: body
      body: ListView(
        children: [
          // Search input field
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: TextField(
                    controller: _blockNewAccountController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Block new account",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.0)),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              // Cancel button
              Expanded(
                flex: 2,
                child: TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    // To close keyboard when pressed
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              // TODO: get blocked list from web services and display it here
            ],
          ),
          // ListView(),
        ],
      ),
    );
  }
}
