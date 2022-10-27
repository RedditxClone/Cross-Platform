import 'package:flutter/material.dart';

class AccountSettingsScreenWeb extends StatefulWidget {
  const AccountSettingsScreenWeb({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreenWeb> createState() =>
      _AccountSettingsScreenWebState();
}

class _AccountSettingsScreenWebState extends State<AccountSettingsScreenWeb> {
  // TODO: make it responsive
  final titleColor = const Color.fromRGBO(215, 218, 220, 1);

  final subtitleColor = const Color.fromRGBO(129, 131, 132, 1);

  final backgroundColor = const Color.fromRGBO(26, 26, 27, 1);
  var _isMale = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(50, 50, 40, 0),
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          children: [
            // title
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                ),
              ),
            ),
            // subtitle
            _accountPreferencesWidget(),
            _connectedAccountsWidget(),
            _deleteAccountWidget()
            //
          ],
        ),
      ),
    );
  }

  Widget _accountPreferencesWidget() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          // Title
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            width: double.infinity,
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Text(
              "ACCOUNT PREFERENCES",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
              ),
            ),
          ),
          // Account settings element
          // TODO: change email pop up
          _accountSettingsElement(
            "Email address",
            "bemoi.erian@gmail.com",
            _rounderButton(
              "Change",
              () {},
            ),
          ),
          // TODO: change password pop up
          _accountSettingsElement(
            "Change password",
            "Password must be at least 8 characters long.",
            _rounderButton(
              "Change",
              () {},
            ),
          ),
          _accountSettingsElement(
            "Gender",
            "Reddit will never share this information and only uses it to improve what content you see.",
            _genderDropDown(),
          ),
          _accountSettingsElement(
            "Country",
            "This is your primary location. Learn more",
            null,
          ),
        ],
      ),
    );
  }

  Widget _connectedAccountsWidget() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          // Title
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            width: double.infinity,
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Text(
              "CONNECTED ACCOUNTS",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
              ),
            ),
          ),
          // Account settings element
          // TODO: Connect to facebook button
          _accountSettingsElement(
            "Connect to Facebook",
            "Connect account to log in to Reddit with Facebook",
            null,
          ),
          // TODO: country dropdown list
          _accountSettingsElement(
            "Connect to Google",
            "Connect account to log in to Reddit with Google",
            null,
          ),

          // TODO: country dropdown list
        ],
      ),
    );
  }

  Widget _deleteAccountWidget() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          // Title
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            width: double.infinity,
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Text(
              "DELETE ACCOUNT",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  // TODO: delete account function
                  onPressed: () {},
                  label: const Text(
                    "DELETE ACCOUNT",
                    style: TextStyle(color: Colors.red),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _accountSettingsElement(title, subtitle, suffixWidget) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: subtitleColor,
                    ),
                  ),
                ],
              )),
          suffixWidget ?? Container()
        ],
      ),
    );
  }

  Widget _rounderButton(title, onPressedFunc) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 85,
      height: 30,
      child: TextButton(
        onPressed: onPressedFunc,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.white),
        ))),
        child: Text(title),
      ),
    );
  }

  Widget _genderDropDown() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 80,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            style: const TextStyle(
              backgroundColor: Colors.transparent,
              color: Colors.white,
            ),
            focusColor: Colors.transparent,
            dropdownColor: Colors.transparent,
            iconEnabledColor: Colors.transparent,
            iconDisabledColor: Colors.transparent,
            iconSize: 0,
            value: _isMale,
            elevation: 1,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text(
                  "Woman",
                ),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("Man"),
              )
            ],
            onChanged: (value) {
              setState(
                () {
                  _isMale = (value ?? 0) as int;
                },
              );
            },
            hint: const Text("Select item")),
      ),
    );
  }
}
