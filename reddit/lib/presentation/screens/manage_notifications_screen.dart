import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Builds the UI of the Manage Notifications screen inside Account settings on Android.
class ManageNotificationsScreen extends StatefulWidget {
  ManageNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<ManageNotificationsScreen> createState() =>
      _ManageNotificationsScreenState();
}

class _ManageNotificationsScreenState extends State<ManageNotificationsScreen> {
  // Messages
  bool? _inboxMessage;
  bool? _chatMessage;
  bool? _chatRequest;
  // Activity
  bool? _mentions;
  bool? _commentsOnPosts;
  bool? _upvotesOnPosts;
  bool? _upvotesOnComments;
  bool? _repliesToComments;
  bool? _newFollowers;
  // Updates
  bool? _cakeDay;
  // Moderation
  bool? _modNotifications;
  // Obtain shared preferences.
  SharedPreferences? prefs;

  /// Get shared prefs instance
  Future<void> getSharedPrefsInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Set local variables with values of shared preferences instance
  Future<void> _setVarsFromSharedPreferences() async {
    if (prefs == null) {
      await getSharedPrefsInstance();
    }
    _initSharedPreferencesIfNull();
    _inboxMessage = prefs!.getBool('inboxMessage');
    _chatMessage = prefs!.getBool('chatMessage');
    _chatRequest = prefs!.getBool('chatRequest');
    // Activity
    _mentions = prefs!.getBool('mentions');
    _commentsOnPosts = prefs!.getBool('commentsOnPosts');
    _upvotesOnPosts = prefs!.getBool('upvotesOnPosts');
    _upvotesOnComments = prefs!.getBool('upvotesOnComments');
    _repliesToComments = prefs!.getBool('repliesToComments');
    _newFollowers = prefs!.getBool('newFollowers');
    // Updates
    _cakeDay = prefs!.getBool('cakeDay');
    // Moderation
    _modNotifications = prefs!.getBool('modNotifications');
    setState(() {});
  }

  /// initialize shared preferences variables if they were not before.
  Future<void> _initSharedPreferencesIfNull() async {
    if (prefs!.getBool('inboxMessage') == null) {
      await prefs!.setBool('inboxMessage', true);
    }
    if (prefs!.getBool('chatMessage') == null) {
      await prefs!.setBool('chatMessage', true);
    }
    if (prefs!.getBool('chatRequest') == null) {
      await prefs!.setBool('chatRequest', true);
    }
    if (prefs!.getBool('mentions') == null) {
      await prefs!.setBool('mentions', true);
    }
    if (prefs!.getBool('commentsOnPosts') == null) {
      await prefs!.setBool('commentsOnPosts', true);
    }
    if (prefs!.getBool('upvotesOnPosts') == null) {
      await prefs!.setBool('upvotesOnPosts', true);
    }
    if (prefs!.getBool('upvotesOnComments') == null) {
      await prefs!.setBool('upvotesOnComments', true);
    }
    if (prefs!.getBool('repliesToComments') == null) {
      await prefs!.setBool('repliesToComments', true);
    }
    if (prefs!.getBool('newFollowers') == null) {
      await prefs!.setBool('newFollowers', true);
    }
    if (prefs!.getBool('cakeDay') == null) {
      await prefs!.setBool('cakeDay', true);
    }
    if (prefs!.getBool('modNotifications') == null) {
      await prefs!.setBool('modNotifications', true);
    }
  }

  @override
  initState() {
    super.initState();
    _setVarsFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification settings")),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              _messagesWidget(),
              _activityWidget(),
              _updatesWidget(),
              _moderationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the UI of the "Messages" category of Manage Notification settings
  Widget _messagesWidget() {
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
              "MESSAGES",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _toggleSettingsButton(
            title: "Inbox message",
            prefixIcon: Icons.mail_outline,
            toggleValue: _inboxMessage,
            onChangedFunc: (value) {
              setState(() {
                _inboxMessage = value;
                prefs!.setBool('inboxMessage', _inboxMessage!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "Chat message",
            prefixIcon: Icons.chat_outlined,
            toggleValue: _chatMessage,
            onChangedFunc: (value) {
              setState(() {
                _chatMessage = value;
                prefs!.setBool('chatMessage', _chatMessage!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "Chat request",
            prefixIcon: Icons.mark_chat_unread_outlined,
            toggleValue: _chatRequest,
            onChangedFunc: (value) {
              setState(() {
                _chatRequest = value;
                prefs!.setBool('chatRequest', _chatRequest!);
              });
            },
          ),
        ],
      ),
    );
  }

  /// Builds the UI of the "Activity" category of Manage Notification settings
  Widget _activityWidget() {
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
              "ACTIVITY",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _toggleSettingsButton(
            title: "Mentions of u/username",
            prefixIcon: Icons.person_outline,
            toggleValue: _mentions,
            onChangedFunc: (value) {
              setState(() {
                _mentions = value;
                prefs!.setBool('mentions', _mentions!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "Comments on your posts",
            prefixIcon: Icons.mode_comment_outlined,
            toggleValue: _commentsOnPosts,
            onChangedFunc: (value) {
              setState(() {
                _commentsOnPosts = value;
                prefs!.setBool('commentsOnPosts', _commentsOnPosts!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "Upvotes on your posts",
            prefixIcon: Icons.arrow_upward,
            toggleValue: _upvotesOnPosts,
            onChangedFunc: (value) {
              setState(() {
                _upvotesOnPosts = value;
                prefs!.setBool('upvotesOnPosts', _upvotesOnPosts!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "Upvotes on your comments",
            prefixIcon: Icons.arrow_upward,
            toggleValue: _upvotesOnComments,
            onChangedFunc: (value) {
              setState(() {
                _upvotesOnComments = value;
                prefs!.setBool('upvotesOnComments', _upvotesOnComments!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "Replies to your comments",
            prefixIcon: Icons.reply,
            toggleValue: _repliesToComments,
            onChangedFunc: (value) {
              setState(() {
                _repliesToComments = value;
                prefs!.setBool('repliesToComments', _repliesToComments!);
              });
            },
          ),
          _toggleSettingsButton(
            title: "New followers",
            prefixIcon: Icons.person_outline,
            toggleValue: _newFollowers,
            onChangedFunc: (value) {
              setState(() {
                _newFollowers = value;
                prefs!.setBool('newFollowers', _newFollowers!);
              });
            },
          ),
        ],
      ),
    );
  }

  /// Builds the UI of the "Updates" category of Manage Notification settings
  Widget _updatesWidget() {
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
              "UPDATES",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _toggleSettingsButton(
            title: "Cake day",
            prefixIcon: Icons.cake_rounded,
            toggleValue: _cakeDay,
            onChangedFunc: (value) {
              setState(() {
                _cakeDay = value;
                prefs!.setBool('cakeDay', _cakeDay!);
              });
            },
          ),
        ],
      ),
    );
  }

  /// Builds the UI of the "Moderation" category of Manage Notification settings
  Widget _moderationWidget() {
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
              "MODERATION",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _toggleSettingsButton(
            title: "Mod notifications",
            prefixIcon: Icons.notifications,
            toggleValue: _modNotifications,
            onChangedFunc: (value) {
              setState(() {
                _modNotifications = value;
                prefs!.setBool('modNotifications', _modNotifications!);
              });
            },
          ),
        ],
      ),
    );
  }

  /// Builds the UI of the toggle button
  Widget _toggleSettingsButton(
      {required title,
      required prefixIcon,
      required toggleValue,
      required onChangedFunc}) {
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
              children: [Text(title)],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Switch(
                  value: toggleValue,
                  onChanged: onChangedFunc,
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
}
