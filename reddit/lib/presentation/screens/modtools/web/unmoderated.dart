import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/screens/modtools/web/left_modlist_web.dart';
import 'package:reddit/presentation/widgets/modtools/web/queue.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class UnmoderatedWeb extends StatefulWidget {
  String subredditName;
  UnmoderatedWeb({super.key, required this.subredditName});

  @override
  State<UnmoderatedWeb> createState() => _UnmoderatedWebWebState();
}

class _UnmoderatedWebWebState extends State<UnmoderatedWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title: UserData.user != null
              ? const AppBarWebLoggedIn(screen: 'r/subreddit')
              : const AppBarWebNotLoggedIn(screen: 'r/subreddit')),
      body: Container(
          color: defaultWebBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeftModList(
                  screen: 'Unmoderated',
                  subredditName: widget.subredditName,
                  subredditId: ''),
              QueuesWidget(
                  screen: 'Unmoderated', subredditName: widget.subredditName)
            ],
          )),
    );
  }
}
