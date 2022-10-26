import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

class AccountSettingsScreen extends StatefulWidget {
  AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _allowPeopleToFollowYou = true;
  bool _isMan = true;

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
              _connectedAccountsSettingsWidget(),
              _blockingAndPermissionsSettingsWidget(),
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
              "BASIC SETTINGS",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // TODO: Get email from api
          _basicSettingsbutton(
            "Update email address",
            "bemoi.erian@gmail.com",
            Icons.settings,
            () {
              Navigator.pushNamed(context, updateEmailAddressRoute);
            },
          ),
          _basicSettingsbutton(
            "Change password",
            "",
            Icons.settings,
            () {
              Navigator.pushNamed(context, changePasswordRoute);
            },
          ),
          _basicSettingsbutton(
              "Manage notifications", "", Icons.notifications, () {}),
          _basicSettingsbutton("Manage emails", "", Icons.email, () {}),
          _genderSettingsButton(Icons.person),
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
          _basicSettingsbutton(
              "Manage blocked accounts", "", Icons.block, () {}),
          _basicSettingsbutton(
              "Chat and messaging permissions", "", Icons.chat_outlined, () {}),
          _toggleSettingsButton(
              "Allow people to follow you",
              "Followers will be notified about posts you make to your profile and see them in their home feed.",
              Icons.person_outline),
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
                AppBar(
                  title: const Text("Select gender"),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
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
                Card(
                  color: Colors.transparent,
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
                  color: Colors.transparent,
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

class UpdateEmailAddressScreen extends StatelessWidget {
  final _emailAddressController = TextEditingController();
  final _redditPasswordController = TextEditingController();
  UpdateEmailAddressScreen({Key? key}) : super(key: key);

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
                  // TODO: get email and username from variables
                  children: const [
                    Text(
                      "u/bemoierian",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("bemoi.erian@gmail.com"),
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

class changePasswordScreen extends StatelessWidget {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  changePasswordScreen({Key? key}) : super(key: key);

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
                  // TODO: get email and username from variables
                  children: const [
                    Text(
                      "u/bemoierian",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("bemoi.erian@gmail.com"),
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
