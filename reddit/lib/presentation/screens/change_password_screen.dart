import 'package:flutter/material.dart';

/// Builds the UI of the Change Password screen inside Account settings on Android.
class ChangePasswordScreen extends StatelessWidget {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  late final String _email;
  late final String _username;
  final Object? arguments;
  ChangePasswordScreen(this.arguments, {Key? key}) : super(key: key) {
    Map<String, String> argMap = arguments as Map<String, String>;
    _email = argMap["email"] ?? "";
    _username = argMap["username"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset password"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: update email address
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.person),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "u/$_username",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_email),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  hintText: "Current password",
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0)),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot password",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  hintText: "New password",
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0)),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  hintText: "Confirm new password",
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0)),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
