import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/model/email_settings.dart';
import 'package:icons_plus/icons_plus.dart';

class EmailSettingsWeb extends StatefulWidget {
  const EmailSettingsWeb({super.key});
  @override
  State<EmailSettingsWeb> createState() => _EmailSettingsWebState();
}

class _EmailSettingsWebState extends State<EmailSettingsWeb> {
  late EmailSettings _emailSettings;
  _EmailSettingsWebState();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmailSettingsCubit>(context).getEmailSettings();
  }

  late Map<String, List<dynamic>> section1 = {
    "Inbox messages": [
      _emailSettings.inboxMessages,
      (newValue) => _emailSettings.inboxMessages = newValue,
      "inbox_messages"
    ],
    "Chat requests": [
      _emailSettings.chatRequests,
      (newValue) => _emailSettings.chatRequests = newValue,
      "chat_requests"
    ],
  };
  late Map<String, List<dynamic>> section2 = {
    "New user welcome": [
      _emailSettings.newUserWelcome,
      (newValue) => _emailSettings.newUserWelcome = newValue,
      "new_user_welcome"
    ],
    "Comments on your posts": [
      _emailSettings.commentsOnPost,
      (newValue) => _emailSettings.commentsOnPost = newValue,
      "comments_on_post"
    ],
    "Replies to your comments": [
      _emailSettings.repliesToComments,
      (newValue) => _emailSettings.repliesToComments = newValue,
      "replies_to_comments"
    ],
    "Upvotes on your posts": [
      _emailSettings.upvotesOnPost,
      (newValue) => _emailSettings.upvotesOnPost = newValue,
      "upvotes_on_post"
    ],
    "Upvotes on your comments": [
      _emailSettings.upvotesOnComments,
      (newValue) => _emailSettings.upvotesOnComments = newValue,
      "upvotes_on_comments"
    ],
    "Username mentions": [
      _emailSettings.usernameMentions,
      (newValue) => _emailSettings.usernameMentions = newValue,
      "username_mentions"
    ],
    "New followers": [
      _emailSettings.newFollowers,
      (newValue) => _emailSettings.newFollowers = newValue,
      "new_followers"
    ],
  };
  late Map<String, List<dynamic>> section3 = {
    "Daily Digest": [
      _emailSettings.dailyDigest,
      (newValue) => _emailSettings.dailyDigest = newValue,
      "daily_digest"
    ],
    "Weekly Recap": [
      _emailSettings.weeklyRecap,
      (newValue) => _emailSettings.weeklyRecap = newValue,
      "weekly_recap"
    ],
    "Community Discovery": [
      _emailSettings.communityDiscovery,
      (newValue) => _emailSettings.communityDiscovery = newValue,
      "community_discovery"
    ],
  };
  late Map<String, List<dynamic>> section4 = {
    "Unsubscribe from all emails": [
      _emailSettings.unsubscribeEmails,
      (newValue) => _emailSettings.unsubscribeEmails = newValue,
      "unsubscribe_emails"
    ],
  };

  void _displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 400,
      content: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: const Color.fromARGB(255, 33, 32, 32),
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

  ///each setting reprensents an entry in the map
  ///value is a list of: value, onChanged function, subtitle if exist
  List<Widget> _createSection(
      sectionTitle, Map<String, List<dynamic>> itemsMap) {
    return [
      Text(sectionTitle,
          style: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey)),
      const Divider(
        color: Color.fromARGB(255, 105, 104, 104),
        thickness: 0,
      ),
      for (MapEntry item in itemsMap.entries)
        _createSwitchListTile(item.key, item.value)
    ];
  }

  Widget _createSwitchListTile(title, infoList) {
    return SwitchListTile(
        key: Key(infoList[2]),
        contentPadding: EdgeInsets.zero,
        inactiveThumbColor: Colors.white,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: const Color.fromARGB(255, 126, 125, 125),
        value: infoList[0],
        title: title != null
            ? Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              )
            : null,
        activeColor: Colors.white,
        onChanged: (value) {
          infoList[0] = value;
          infoList[1](value);
          BlocProvider.of<EmailSettingsCubit>(context)
              .updateEmailSettings(_emailSettings);
        });
  }

  Widget _buildSettingsList() {
    return BlocBuilder<EmailSettingsCubit, EmailSettingsState>(
        builder: (context, state) {
      if (state is EmailSettingsLoaded) {
        _emailSettings = (state).emailSettings;
        return SingleChildScrollView(
            child: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.fromLTRB(
                constraints.maxWidth > 900
                    ? MediaQuery.of(context).size.width / 10
                    : MediaQuery.of(context).size.width / 14,
                20,
                10,
                20),
            child: SizedBox(
              width: constraints.maxWidth > 720
                  ? 720 - 35
                  : MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 25),
                      child: Text(
                        "Manage Emails",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _createSection("MESSAGES", section1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _createSection("ACTIVITY", section2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _createSection("NEWSLETTERS", section3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45, bottom: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _createSection("", section4)),
                    )
                  ]),
            ),
          ),
        ));
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EmailSettingsCubit, EmailSettingsState>(
        listener: (context, state) {
          if (state is EmailSettingsUpdated) {
            _displayMsg(context, Colors.blue, 'Changes Saved');
          }
        },
        child: _buildSettingsList(),
      ),
      backgroundColor: const Color.fromARGB(195, 37, 38, 39),
    );
  }
}
