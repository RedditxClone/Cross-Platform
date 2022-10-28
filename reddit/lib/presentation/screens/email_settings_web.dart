import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/bloc/email_settings_bloc.dart';

class EmailSettingsWeb extends StatefulWidget {
  const EmailSettingsWeb({super.key, required this.userId});
  final int userId;
  @override
  State<EmailSettingsWeb> createState() => _EmailSettingsWebState(userId);
}

class _EmailSettingsWebState extends State<EmailSettingsWeb> {
  final int userId;

  _EmailSettingsWebState(this.userId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValues = BlocProvider.of<EmailSettingsBloc>(context)
        .getEmailSettings(userId);
  }

  late final List<bool> _initialValues;
  void _newState(value, oldValue, String title) {
    if (oldValue < 2) {
      section1[title]?[0] = value;
    } else if (oldValue < 9) {
      section2[title]?[0] = value;
    } else if (oldValue < 12) {
      section3[title]?[0] = value;
    } else {
      section4[title]?[0] = value;
    }

    setState(() {});
  }

  late Map<String, List<dynamic>> section1 = {
    "Inbox messages": [
      _initialValues[0],
      (value) {
        _newState(value, 0, "Inbox messages");
      }
    ],
    "Chat requests": [
      _initialValues[1],
      (value) {
        _newState(value, 1, "Chat requests");
      }
    ]
  };
  late Map<String, List<dynamic>> section2 = {
    "New user welcome": [
      _initialValues[2],
      (value) {
        _newState(value, 2, "New user welcome");
      }
    ],
    "Comments on your posts": [
      _initialValues[3],
      (value) {
        _newState(value, 3, "Comments on your posts");
      }
    ],
    "Replies to your comments": [
      _initialValues[4],
      (value) {
        _newState(value, 4, "Replies to your comments");
      }
    ],
    "Upvotes on your posts": [
      _initialValues[5],
      (value) {
        _newState(value, 5, "Upvotes on your posts");
      }
    ],
    "Upvotes on your comments": [
      _initialValues[6],
      (value) {
        _newState(value, 6, "Upvotes on your comments");
      }
    ],
    "Username mentions": [
      _initialValues[7],
      (value) {
        _newState(value, 7, "Username mentions");
      }
    ],
    "New followers": [
      _initialValues[8],
      (value) {
        _newState(value, 8, "New followers");
      }
    ]
  };
  late Map<String, List<dynamic>> section3 = {
    "Daily Digest": [
      _initialValues[9],
      (value) {
        _newState(value, 9, "Daily Digest");
      }
    ],
    "Weekly Recap": [
      _initialValues[10],
      (value) {
        _newState(value, 10, "Weekly Recap");
      }
    ],
    "Community Discovery": [
      _initialValues[11],
      (value) {
        _newState(value, 11, "Community Discovery");
      }
    ]
  };
  late Map<String, List<dynamic>> section4 = {
    "Unsubscribe from all emails": [
      _initialValues[12],
      (value) {
        _newState(value, 12, "Unsubscribe from all emails");
      }
    ]
  };

  ///each setting reprensents an entry in the map
  ///value is a list of: value, onChanged function, subtitle if exist
  List<Widget> _createSection(
      sectionTitle, Map<String, List<dynamic>> itemsMap) {
    return [
      Text(sectionTitle,
          style: const TextStyle(fontSize: 15, color: Colors.grey)),
      const Divider(),
      for (MapEntry itemList in itemsMap.entries)
        _createSwitchListTile(
            itemList.key,
            itemList.value[0],
            itemList.value[1],
            itemList.value.length > 2 ? itemList.value[2] : null)
    ];
  }

  Widget _createSwitchListTile(title, value, onChanged, subtitle) {
    return SwitchListTile(
        value: value,
        title: title != null ? Text(title) : null,
        subtitle: subtitle != null ? Text(subtitle) : null,
        activeColor: Colors.blue,
        onChanged: onChanged);
  }

  Widget _buildSettingsList() {
    return BlocBuilder<EmailSettingsBloc, EmailSettingsState>(
        builder: (context, state) {
      if (state is EmailSettingsLoaded) {
        _initialValues = (state).initialValues;
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(170, 20, 670, 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 25),
              child: Text(
                "Manage Emails",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _createSection("MESSAGES", section1),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _createSection("ACTIVITY", section2),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _createSection("NEWSLETTERS", section3),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _createSection("", section4))
          ]),
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
    return Scaffold(appBar: AppBar(), body: _buildSettingsList());
  }
}
