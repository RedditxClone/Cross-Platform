import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/data/model/change_password_model.dart';

/// Builds the UI of the Change Password screen inside Account settings on Android.
class ChangePasswordScreen extends StatelessWidget {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  late final String _email;
  late final String _username;
  final Object? arguments;
  ChangePasswordScreen(this.arguments, {Key? key}) : super(key: key) {
    Map<String, dynamic> argMap = arguments as Map<String, dynamic>;
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
              _tryChangePassword(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: BlocListener<AccountSettingsCubit, AccountSettingsState>(
        listener: (context, state) {
          if (state is PasswordUpdatedSuccessfully) {
            displayMsg(context, Colors.white, Colors.green,
                "Password updated successfully", "");
          } else if (state is WrongPassword) {
            displayMsg(
                context, Colors.white, Colors.green, "Wrong password", "");
          }
        },
        child: buildChangePasswordScreen(),
      ),
    );
  }

  /// Validate input
  /// Change password if inputs are valid
  /// Show warning if inputs are not valid
  void _tryChangePassword(context) {
    // All parameters correct case, call changePassword function
    if (_newPasswordController.text == _confirmNewPasswordController.text &&
        _newPasswordController.text.length >= 8 &&
        _currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty) {
      BlocProvider.of<AccountSettingsCubit>(context).changePassword(
        ChangePasswordModel(
          oldPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        ),
      );
      // Navigator.pop(context);
      // Password less than 8 characters, display warning
    } else if (_currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmNewPasswordController.text.isNotEmpty &&
        _newPasswordController.text.length < 8) {
      displayMsg(
          context,
          Colors.white,
          Colors.red,
          "Sorry, your password must be at least 8 characters long. Try that again.",
          "");
      // New password and confirm new password does not match, display warning
    } else if (_currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmNewPasswordController.text.isNotEmpty &&
        _newPasswordController.text != _confirmNewPasswordController.text) {
      displayMsg(context, Colors.white, Colors.red,
          "Oops, your password don't match. Try that again", "");
      // Not all fields are filled, display warning
    } else {
      displayMsg(context, Colors.white, Colors.red,
          "Oops, you forgot to fill everything out.", "");
    }
  }

  /// Widget that builds the change password screen on mobile.
  Widget buildChangePasswordScreen() {
    return SingleChildScrollView(
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
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
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
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
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
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
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
    );
  }

  void displayMsg(BuildContext context, Color textColor, Color leftBarColor,
      String title, String subtitle) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          height: 65,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: leftBarColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 7,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 15, color: textColor),
                      softWrap: true,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: textColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
