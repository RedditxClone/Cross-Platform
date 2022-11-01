import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/country_names.dart';

///Widget that constructs the Account Settings screen on Android
class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  /// Account settings model retrieved from backend
  AccountSettingsModel? accountSettings;
  bool _isMan = true;
  String _country = "";
  // get this value from previous screen
  final String _email = "bemoi.erian@gmail.com";
  final String _username = "bemoierian";
  final Uri _countryLearnMoreUrl =
      Uri.parse('https://reddithelp.com/hc/en-us/articles/360062429491');

  /// Calling bloc BlocProvider inside initState
  ///
  /// load the user's settings initialy from backend.
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountSettingsCubit>(context).getAccountSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account settings")),
      body: buildAccountSettingsBloc(),
    );
  }

  /// Build UI of account settings screen using BlocBuilder
  Widget buildAccountSettingsBloc() {
    return BlocBuilder<AccountSettingsCubit, AccountSettingsState>(
      builder: (context, state) {
        if (state is AccountSettingsLoaded) {
          accountSettings = state.accSettings;
          _isMan = accountSettings!.gender == "M" ? true : false;
          // Get country name from country code returned from server
          for (var map in countryNamesMap) {
            if (map["code"] == accountSettings!.countryCode) {
              _country = map["name"]!;
            }
          }
          return Container(
            color: Colors.black,
            child: ListView(
              children: [
                _basicSettingsWidget(context),
                _connectedAccountsSettingsWidget(),
                _blockingAndPermissionsSettingsWidget(),
              ],
            ),
          );
        } else if (state is AccountSettingsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.yellow,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.yellow,
            ),
          );
        }
      },
    );
  }

  /// Builds the UI of the basic settings category of Account Settings
  Widget _basicSettingsWidget(context) {
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
          _basicSettingsButton(
            "Update email address",
            _email,
            Icons.settings,
            () {
              Navigator.pushNamed(context, updateEmailAddressRoute,
                  arguments: {"email": _email, "username": _username});
            },
          ),
          _basicSettingsButton(
            "Change password",
            "",
            Icons.settings,
            () {
              Navigator.pushNamed(context, changePasswordRoute,
                  arguments: {"email": _email, "username": _username});
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
          _genderSettingsButton(Icons.person, context),
          _countryButton(
            "Country",
            "This is your primary location,",
            Icons.location_on_outlined,
            () async {
              var countryMap = await Navigator.pushNamed(context, countryRoute,
                      arguments: {"code": accountSettings!.countryCode})
                  as Map<String, String>;
              print("countryMap: $countryMap");
              accountSettings!.countryCode =
                  countryMap["code"] ?? accountSettings!.countryCode;
              BlocProvider.of<AccountSettingsCubit>(context)
                  .updateAccountSettings(accountSettings!);
            },
          ),
        ],
      ),
    );
  }

  /// Builds the UI of the "Connected Accounts" category of Account Settings
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
          _connectedAccountsButton("Google"),
          _connectedAccountsButton("Facebook"),
        ],
      ),
    );
  }

  /// Builds the UI of the "Blocking and permissions" category of Account Settings
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

          // TODO: Get list of blocked from api
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

  /// Builds the UI of a button with title, subtitle, prefix icon and a customized on press function
  Widget _basicSettingsButton(title, subtitle, prefixIcon, onPressedFunc) {
    return TextButton(
      onPressed: onPressedFunc,
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
    );
  }

  /// Builds the UI of the country button.
  Widget _countryButton(title, subtitle, prefixIcon, onPressedFunc) {
    return TextButton(
      onPressed: onPressedFunc,
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchUrl(_countryLearnMoreUrl);
                        },
                    ),
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
    );
  }

  /// Launches a given url on the phone screen
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  /// Builds the UI of "Connect to google", "Connect to facebook" button
  Widget _connectedAccountsButton(title) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title == "Google"
                    ? Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover)
                    : const Icon(Icons.facebook),
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

  /// Builds the UI of a button with title, subtitle, prefix icon and a switch.
  Widget _toggleSettingsButton(title, subtitle, prefixIcon) {
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
                  value: accountSettings!.enableFollowers,
                  onChanged: ((value) {
                    accountSettings!.enableFollowers = value;
                    // Update settings request
                    BlocProvider.of<AccountSettingsCubit>(context)
                        .updateAccountSettings(accountSettings!);
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

  /// Builds the UI of the "Select gender" button.
  Widget _genderSettingsButton(prefixIcon, context) {
    return TextButton(
      onPressed: () => _genderBottomSheet(context),
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
    );
  }

  /// Builds the UI of the bottom sheet shown when choosing gender.
  void _genderBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<AccountSettingsCubit>(context),
          child: Container(
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
                      ),
                    ),
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
                      // setState(() {
                      //   _isMan = true;
                      // });

                      Navigator.pop(context);
                      accountSettings!.gender = "M";
                      // Update settings request
                      BlocProvider.of<AccountSettingsCubit>(context)
                          .updateAccountSettings(accountSettings!);
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
                      // setState(() {
                      //   _isMan = false;
                      // });
                      Navigator.pop(context);
                      accountSettings!.gender = "W";
                      // Update settings request
                      BlocProvider.of<AccountSettingsCubit>(context)
                          .updateAccountSettings(accountSettings!);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
