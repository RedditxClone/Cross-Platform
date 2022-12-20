import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

/// Builds the UI of the Manage Blocked Accounts screen inside Account settings on Android.
class ManageBlockedAccountsScreen extends StatefulWidget {
  const ManageBlockedAccountsScreen({Key? key}) : super(key: key);

  @override
  State<ManageBlockedAccountsScreen> createState() =>
      _ManageBlockedAccountsScreenState();
}

class _ManageBlockedAccountsScreenState
    extends State<ManageBlockedAccountsScreen> {
  final _blockNewAccountController = TextEditingController();
  List<User>? blockedUsers;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SafetySettingsCubit>(context).getUserSettings();
  }

  /// [context] : build context.
  /// [color] : color of the error msg to be displayer e.g. ('red' : error , 'blue' : success ).
  /// [title] : message to be displayed to the user.
  void displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 400,
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
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 9,
              ),
              Logo(
                Logos.reddit,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget _user(String profilepic, String username) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: defaultSecondaryColor,
            child: profilepic == ''
                ? const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 24,
                  )
                : Image.network(
                    profilepic,
                    fit: BoxFit.cover,
                  ), //comminty icon
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListElement(index) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _user(blockedUsers![index].profilePic!, blockedUsers![index].username??""),
      OutlinedButton(
        onPressed: () {
          displayMsg(context, Colors.green,
              '${blockedUsers![index].username} unblocked');
          BlocProvider.of<SafetySettingsCubit>(context).unBlockUser(
              UserData.safetySettings!, blockedUsers![index].userId??"");
        },
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
            side: const BorderSide(width: 1, color: Colors.blue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: const Text(
          "unblock",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blocked accounts"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Search input field
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  height: 70,
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
          BlocBuilder<SafetySettingsCubit, SafetySettingsState>(
            builder: (context, state) {
              if (state is SafetySettingsAvailable) {
                blockedUsers = state.settings.blocked;
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: blockedUsers!.length,
                      itemBuilder: (context, index) {
                        return _buildListElement(index);
                      }),
                );
              } else if (state is BlockListUpdated) {
                blockedUsers = state.settings.blocked;
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: blockedUsers!.length,
                      itemBuilder: (context, index) {
                        return _buildListElement(index);
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
