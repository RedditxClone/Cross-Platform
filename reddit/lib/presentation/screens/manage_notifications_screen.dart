import 'package:flutter/material.dart';

class ManageNotificationsScreen extends StatefulWidget {
  ManageNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<ManageNotificationsScreen> createState() =>
      _ManageNotificationsScreenState();
}

class _ManageNotificationsScreenState extends State<ManageNotificationsScreen> {
  // TODO: Get these values from web services
  // Messages
  bool _inboxMessage = true;
  bool _chatMessage = true;
  bool _chatRequest = true;
  // Activity
  bool _mentions = true;
  bool _commentsOnPosts = true;
  bool _upvotesOnPosts = true;
  bool _upvotesOnComments = true;
  bool _repliesToComments = true;
  bool _newFollowers = true;
  // Updates
  bool _cakeDay = true;
  // Moderation
  bool _modNotifications = true;

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
              });
            },
          ),
        ],
      ),
    );
  }

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
              });
            },
          ),
        ],
      ),
    );
  }

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
              });
            },
          ),
        ],
      ),
    );
  }

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
              });
            },
          ),
        ],
      ),
    );
  }

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
