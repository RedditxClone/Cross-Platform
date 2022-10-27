import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _allowPeopleToFollowYou = true;
  bool _isMan = true;
  final String _country = "Egypt";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account settings")),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            _basicSettingsWidget(),
            _connectedAccountsSettingsWidget(),
            _blockingAndPermissionsSettingsWidget(),
          ],
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
              "BASIC SETTINGS",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // TODO: Get email from api
          _basicSettingsButton(
            "Update email address",
            "bemoi.erian@gmail.com",
            Icons.settings,
            () {
              Navigator.pushNamed(context, updateEmailAddressRoute);
            },
          ),
          _basicSettingsButton(
            "Change password",
            "",
            Icons.settings,
            () {
              Navigator.pushNamed(context, changePasswordRoute);
            },
          ),
          _basicSettingsButton(
            "Manage notifications",
            "",
            Icons.notifications,
            () {
              Navigator.pushNamed(context, manageNotificationsRoute);
            },
          ),
          _genderSettingsButton(Icons.person),
          // TODO: add a link to learn more
          // TODO: add the selected country name at the end of the button
          _countryButton(
            "Country",
            "This is your primary location,",
            Icons.location_on_outlined,
            () {
              Navigator.pushNamed(context, countryRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _connectedAccountsSettingsWidget() {
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
              "CONNECTED ACCOUNTS",
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

  Widget _blockingAndPermissionsSettingsWidget() {
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
              "BLOCKING AND PERMISSIONS",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // TODO: Get email from api
          _basicSettingsButton(
            "Manage blocked accounts",
            "",
            Icons.block,
            () {
              Navigator.pushNamed(context, manageBlockedAccountsRoute);
            },
          ),
          _toggleSettingsButton(
              "Allow people to follow you",
              "Followers will be notified about posts you make to your profile and see them in their home feed.",
              Icons.person_outline),
        ],
      ),
    );
  }

  Widget _basicSettingsButton(title, subtitle, prefixIcon, onPressedFunc) {
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

  Widget _countryButton(title, subtitle, prefixIcon, onPressedFunc) {
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
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: subtitle,
                          style: TextStyle(color: Colors.grey.shade500)),
                      TextSpan(
                          text: " Learn more",
                          style: const TextStyle(color: Colors.blue),
                          // TODO: on tap not working because it is the child of a button
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_country),
                ],
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
      padding: const EdgeInsets.all(8.0),
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleSettingsButton(title, subtitle, prefixIcon) {
    // TODO: subtitle text style
    return Container(
      padding: const EdgeInsets.all(8.0),
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
              children: [
                Switch(
                  value: _allowPeopleToFollowYou,
                  onChanged: ((value) {
                    setState(() {
                      _allowPeopleToFollowYou = value;
                    });
                  }),
                  activeColor: Colors.indigo.shade700,
                  thumbColor: MaterialStateProperty.all(Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderSettingsButton(prefixIcon) {
    // TODO: subtitle text style
    return TextButton(
      onPressed: _genderBottomSheet,
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
                children: [
                  const Text("Gender"),
                  Text(
                    _isMan ? "Man" : "Woman",
                    style: TextStyle(color: Colors.grey.shade500),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: adjust colors
  void _genderBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.grey.shade900,
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PreferredSize(
                  preferredSize: AppBar().preferredSize,
                  child: AppBar(
                    title: const Text("Select gender"),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.grey.shade900,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    )),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // set gender
                          Navigator.pop(context);
                        },
                        child: const Text("Done"),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.grey.shade900,
                  child: ListTile(
                    title: const Text("Man"),
                    leading: _isMan
                        ? const Icon(Icons.check_circle)
                        : const Icon(Icons.circle_outlined),
                    onTap: () {
                      setState(() {
                        _isMan = true;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  color: Colors.grey.shade900,
                  child: ListTile(
                    title: const Text("Woman"),
                    leading: !_isMan
                        ? const Icon(Icons.check_circle)
                        : const Icon(Icons.circle_outlined),
                    onTap: () {
                      setState(() {
                        _isMan = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
