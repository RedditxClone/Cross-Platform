import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account settings")),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              _basicSettingsWidget(),
              _connectedAccountsWidget(),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  Widget _basicSettingsWidget() {
    return Container(
      color: Colors.grey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            color: Colors.black,
            child: Text(
              "Basic settings",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // TODO: Get username from api
          // TODO: Get username from api
          _basicSettingsbutton(
              "Switch accounts", "u/bemoi", Icons.person, () {}),
          // TODO: Get email from api
          _basicSettingsbutton("Update email address", "bemoi.erian@gmail.com",
              Icons.settings, () {}),
          _basicSettingsbutton("Change password", "", Icons.settings, () {}),
          _basicSettingsbutton(
              "Manage notifications", "", Icons.notifications, () {}),
          _basicSettingsbutton("Manage emails", "", Icons.email, () {}),
          _basicSettingsbutton("Gender", "Man", Icons.person, () {}),
          // TODO: add a link to learn more
          // TODO: add the selected country name at the end of the button
          _basicSettingsbutton(
              "Country",
              "This is your primary location, Learn more",
              Icons.location_on_outlined,
              () {}),
        ],
      ),
    );
  }

  Widget _connectedAccountsWidget() {
    return Container(
      color: Colors.grey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            color: Colors.black,
            child: Text(
              "Connected accounts",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // TODO: Get username from api
          // TODO: Get username from api
          _connectedAccountsButton("Google", Icons.android),
          // TODO: Get email from api
          _connectedAccountsButton("Facebook", Icons.facebook),
        ],
      ),
    );
  }

  Widget _basicSettingsbutton(title, subtitle, prefixIcon, onPressedFunc) {
    // TODO: subtitle text style
    return TextButton(
      onPressed: onPressedFunc,
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(prefixIcon),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (subtitle == ""
                    ? [Text(title)]
                    : [
                        Text(title),
                        Text(
                          subtitle,
                          style: TextStyle(color: Colors.grey.shade500),
                        )
                      ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _connectedAccountsButton(title, prefixIcon) {
    // TODO: subtitle text style
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(prefixIcon),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                ]),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    // TODO: add links
                    onPressed: () {},
                    child: const Text(
                      "Connect",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
