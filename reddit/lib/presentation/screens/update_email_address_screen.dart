import 'package:flutter/material.dart';

class UpdateEmailAddressScreen extends StatelessWidget {
  final _emailAddressController = TextEditingController();
  final _redditPasswordController = TextEditingController();
  late final String _email;
  late final String _username;
  final Object? arguments;
  UpdateEmailAddressScreen(this.arguments, {Key? key}) : super(key: key) {
    Map<String, String> argMap = arguments as Map<String, String>;
    _email = argMap["email"] ?? "";
    _username = argMap["username"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update email address"),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_email),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
              child: Text(
                "Be sure to verify your new email address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
              child: Text(
                  "We'll send an email with a link to verify your update to your new email address."),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _emailAddressController,
                decoration: InputDecoration(
                  hintText: "New email address",
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
                controller: _redditPasswordController,
                decoration: InputDecoration(
                  hintText: "Reddit password",
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
            )
          ],
        ),
      ),
    );
  }
}
