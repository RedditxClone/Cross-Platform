import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/change_password_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../business_logic/cubit/cubit/account_settings_cubit.dart';
import '../../../constants/country_names.dart';
import '../../../data/model/account_settings_model.dart';
import '../../../data/model/change_password_model.dart';

class AccountSettingsScreenWeb extends StatefulWidget {
  const AccountSettingsScreenWeb({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreenWeb> createState() =>
      _AccountSettingsScreenWebState();
}

class _AccountSettingsScreenWebState extends State<AccountSettingsScreenWeb> {
  AccountSettingsModel? accountSettings;

  final _updatePasswordOldPasswordController = TextEditingController();
  final _updatePasswordNewPasswordController = TextEditingController();
  final _updatePasswordConfirmNewPasswordController = TextEditingController();
  final _changeEmailCurrentPasswordController = TextEditingController();
  final _changeEmailNewEmailController = TextEditingController();
  final titleColor = const Color.fromRGBO(215, 218, 220, 1);

  final subtitleColor = const Color.fromRGBO(129, 131, 132, 1);

  final backgroundColor = const Color.fromRGBO(26, 26, 27, 1);
  var _isMale = 0;
  // Country Learn more URL
  final Uri _countryLearnMoreUrl =
      Uri.parse('https://reddithelp.com/hc/en-us/articles/360062429491');
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountSettingsCubit>(context).getAccountSettings();
  }

  /// Function that return true if the width of the screen is considered small.
  ///
  /// Small width = 650
  /// Used in responsive design
  bool _isSmallSizedScreen() {
    return MediaQuery.of(context).size.width < 650 ? true : false;
  }

  /// Function that return true if the width of the screen is considered medium.
  ///
  /// Medium width = 650 -> 1000
  /// Used in responsive design
  bool _isMediumSizedScreen() {
    return MediaQuery.of(context).size.width >= 650 &&
            MediaQuery.of(context).size.width < 1000
        ? true
        : false;
  }

  /// Function that return true if the width of the screen is considered large.
  ///
  /// Medium width > 1000
  /// Used in responsive design
  bool _isLargeSizedScreen() {
    return (MediaQuery.of(context).size.width >= 1000) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is PasswordUpdatedSuccessfully) {
          displayMsg(context, Colors.white, Colors.green,
              "Password updated successfully");
        } else if (state is WrongPassword) {
          displayMsg(context, Colors.white, Colors.green, "Wrong password");
        }
      },
      child: BlocBuilder<AccountSettingsCubit, AccountSettingsState>(
        builder: (context, state) {
          if (state is AccountSettingsLoaded) {
            accountSettings = state.accSettings;
            _isMale = accountSettings!.gender == "male"
                ? 1
                : accountSettings!.gender == ""
                    ? 2
                    : 0;
            return buildAccountSettingsUI();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildAccountSettingsUI() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          // title
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
          // _connectedAccountsWidget(),
          _deleteAccountWidget()
          //
        ],
      ),
    );
  }

  /// Builds the UI of the Account Preferences category of Account Settings
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
          // TODO: change email function
          _accountSettingsElement(
            "Email address",
            "bemoi.erian@gmail.com",
            _rounderButton(
              "Change",
              () => _showChangeEmailPopUp(),
            ),
          ),
          // TODO: change password pop up
          _accountSettingsElement(
            "Change password",
            "Password must be at least 8 characters long.",
            _rounderButton(
              "Change",
              () => _showChangePasswordPopUp(),
            ),
          ),
          _accountSettingsElement(
            "Gender",
            "Reddit will never share this information and only uses it to improve what content you see.",
            _genderDropDown(),
          ),
          _countryElement(),
          // Country dropdown list
          DropdownButtonHideUnderline(
            child: DropdownButton(
              // Initial Value
              value: accountSettings!.countryCode,

              // Array list of items
              items: countryNamesMap.map((e) {
                return DropdownMenuItem(
                  value: e["code"]!,
                  child: Text(e["name"]!),
                );
              }).toList(),

              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                accountSettings!.countryCode = newValue!;
                BlocProvider.of<AccountSettingsCubit>(context)
                    .updateAccountSettings(accountSettings!);
              },
            ),
          )
        ],
      ),
    );
  }

  void _showChangeEmailPopUp() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          color: backgroundColor,
          width: 450,
          height: 370,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.mail),
                    ),
                    Text(
                      "Update your email",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "Update your email below. There will be a new verification email sent that you will need to use to verify this new email.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _changeEmailCurrentPasswordController,
                  decoration: InputDecoration(
                    hintText: "CURRENT PASSWORD",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _changeEmailNewEmailController,
                  decoration: InputDecoration(
                    hintText: "NEW EMAIL",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordPopUp() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          color: backgroundColor,
          width: 500,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.mail),
                    ),
                    Text(
                      "Change password",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _updatePasswordOldPasswordController,
                  decoration: InputDecoration(
                    hintText: "OLD PASSWORD",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _updatePasswordNewPasswordController,
                  decoration: InputDecoration(
                    hintText: "NEW PASSWORD",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _updatePasswordConfirmNewPasswordController,
                  decoration: InputDecoration(
                    hintText: "CONFIRM NEW PASSWORD",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {
                          _tryChangePassword(context);
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the UI of the Connected Accounts category of Account Settings
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
          // TODO: Connect to facebook function
          _accountSettingsElement("Connect to Facebook",
              "Connect account to log in to Reddit with Facebook", null
              // SignInButton(
              //   Buttons.Facebook,
              //   text: "Connect to Facebook",
              //   onPressed: () {},
              // ),
              ),
          // TODO: Connect to google function
          _accountSettingsElement("Connect to Google",
              "Connect account to log in to Reddit with Google", null
              // SignInButton(
              //   Buttons.Google,
              //   text: "Connect to Google",
              //   onPressed: () {},
              // ),
              ),
        ],
      ),
    );
  }

  /// Builds the UI of the Delete Account category of Account Settings
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

  /// Builds the UI of each element inside Account Settings
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

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  /// Builds the UI of the Country element inside Account Settings
  Widget _countryElement() {
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
                    "Country",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "This is your primary location.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: subtitleColor,
                          )),
                      TextSpan(
                        text: " Learn more",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchUrl(_countryLearnMoreUrl);
                          },
                      ),
                    ]),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /// Builds the Round button used in "Change email", "Change Password"
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

  /// Builds the dropdown list of "Choose Country"
  Widget _genderDropDown() {
    // ignore: sized_box_for_whitespace
    return Container(
      // width: 85,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            style: const TextStyle(
              backgroundColor: Colors.transparent,
              color: Colors.white,
            ),
            focusColor: Colors.transparent,
            dropdownColor: Colors.transparent,
            // iconEnabledColor: Colors.transparent,
            // iconDisabledColor: Colors.transparent,
            // iconSize: 0,
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
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Prefer not to say"),
              )
            ],
            onChanged: (value) {
              accountSettings!.gender = (value == 1
                  ? "male"
                  : value == 0
                      ? "female"
                      : "");
              // debugPrint("Gender value $value");
              BlocProvider.of<AccountSettingsCubit>(context)
                  .updateAccountSettings(accountSettings!);
            },
            hint: const Text("Select item")),
      ),
    );
  }

  /// Validate input
  /// Change password if inputs are valid
  /// Show warning if inputs are not valid
  void _tryChangePassword(context) {
    // All parameters correct case, call changePassword function
    if (_updatePasswordNewPasswordController.text ==
            _updatePasswordConfirmNewPasswordController.text &&
        _updatePasswordNewPasswordController.text.length >= 8 &&
        _updatePasswordOldPasswordController.text.isNotEmpty &&
        _updatePasswordNewPasswordController.text.isNotEmpty) {
      BlocProvider.of<ChangePasswordCubit>(context).changePassword(
        ChangePasswordModel(
          oldPassword: _updatePasswordOldPasswordController.text,
          newPassword: _updatePasswordNewPasswordController.text,
        ),
      );
      // Navigator.pop(context);
      // Password less than 8 characters, display warning
    } else if (_updatePasswordOldPasswordController.text.isNotEmpty &&
        _updatePasswordNewPasswordController.text.isNotEmpty &&
        _updatePasswordConfirmNewPasswordController.text.isNotEmpty &&
        _updatePasswordNewPasswordController.text.length < 8) {
      displayMsg(
        context,
        Colors.white,
        Colors.red,
        "Sorry, your password must be at least 8 characters long. Try that again.",
      );
      // New password and confirm new password does not match, display warning
    } else if (_updatePasswordOldPasswordController.text.isNotEmpty &&
        _updatePasswordNewPasswordController.text.isNotEmpty &&
        _updatePasswordConfirmNewPasswordController.text.isNotEmpty &&
        _updatePasswordNewPasswordController.text !=
            _updatePasswordConfirmNewPasswordController.text) {
      displayMsg(context, Colors.white, Colors.red,
          "Oops, your password don't match. Try that again");
      // Not all fields are filled, display warning
    } else {
      displayMsg(context, Colors.white, Colors.red,
          "Oops, you forgot to fill everything out.");
    }
  }

  void displayMsg(
      BuildContext context, Color textColor, Color leftBarColor, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 500,
      content: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: leftBarColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 9,
              ),
              // Logo(
              //   Logos.reddit,
              //   color: Colors.white,
              //   size: 20,
              // ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 3,
    ));
  }
}
