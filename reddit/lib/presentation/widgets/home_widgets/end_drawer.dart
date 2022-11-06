import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/constants/strings.dart';

class EndDrawer extends StatelessWidget {
  final int _karma = 2;
  final int _redditAge = 34;
  final String _username = "bemoierian";
  final String _profilePicture = "";
  late bool _isLoggedIn;
  EndDrawer(this._isLoggedIn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: 300,
      child: _isLoggedIn
          ? _buildLoggedInEndDrawer(context)
          : _buildLoggedOutEndDrawer(context),
    );
  }

  Widget _buildLoggedInEndDrawer(context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            _buildProfilePicture(),
            _buildUsernameButton(context),
            _buildOnlineStatus(),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
          ],
        ),
        _buildKarmaAndRedditCake(),
        _buildScrollViewButtons(),
        _buildSettingsButton(context),
      ],
    );
  }

  Widget _buildLoggedOutEndDrawer(context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              height: 100,
            ),
            Icon(
              Icons.person_pin,
              size: 100,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Sign up to upvote the best content, customize your feed, share your interests, and more!",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Sign up / Log in"),
                onTap: () {
                  // TODO: go to sign up / log in page
                },
              ),
              _buildSettingsButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return const Icon(
      Icons.person_pin,
      size: 100,
    );
  }

  Widget _buildSettingsButton(context) {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("Settings"),
      onTap: () {
        // TODO: this may be changed by another settings page
        // Navigator.of(context).pop();
        Navigator.of(context).pushNamed(accountSettingsRoute);
      },
    );
  }

  Widget _buildScrollViewButtons() {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("My profile"),
                onTap: () {},
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.plus),
                title: const Text("Create a community"),
                onTap: () {},
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.bookmark),
                title: const Text("Saved"),
                onTap: () {},
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.clock),
                title: const Text("History"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.paste_outlined),
                title: const Text("Pending posts"),
                onTap: () {},
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.fileLines),
                title: const Text("Drafts"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKarmaAndRedditCake() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: const FaIcon(
                    FontAwesomeIcons.dharmachakra,
                    color: Colors.blue,
                  ),
                  title: Text("$_karma"),
                  subtitle: const Text("Karma"),
                ),
              ),
              VerticalDivider(
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: const FaIcon(
                    FontAwesomeIcons.cakeCandles,
                    color: Colors.blue,
                  ),
                  title: Text("$_redditAge d"),
                  subtitle: const Text("Reddit age"),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade600,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }

  Widget _buildOnlineStatus() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(50),
      ),
      child: SizedBox(
        width: 150,
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.circle,
                color: Colors.green,
                size: 15,
              ),
            ),
            Text(
              "Online Status: On",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameButton(context) {
    return TextButton(
      onPressed: () => _accountsBottomSheet(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "u/$_username",
            style: const TextStyle(
              fontSize: 19,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_outlined)
        ],
      ),
    );
  }

  void _accountsBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.98,
      ),
      builder: (_) {
        return SizedBox(
          width: double.infinity,
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 0, 0),
                child: Text("ACCOUNTS"),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text("u/$_username"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        // Logout bottomsheet
                        Navigator.of(context).pop();
                        _logOutBottomSheet(context);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  // TODO: Add account function
                },
                leading: const Icon(Icons.add),
                title: const Text("Add account"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade800,
                  ),
                  child: const Text(
                    "CLOSE",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _logOutBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.98,
      ),
      builder: (_) {
        return SizedBox(
          width: double.infinity,
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
                child: Text("U/${_username.toUpperCase()}"),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  // Logout function
                },
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade800,
                  ),
                  child: const Text(
                    "CLOSE",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
