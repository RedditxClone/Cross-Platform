import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/screens/modtools/web/left_modlist_web.dart';
import 'package:reddit/presentation/widgets/modtools/web/queue.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class ModQueueWeb extends StatefulWidget {
  String subredditName;
  final String subredditId;
  ModQueueWeb(
      {super.key, required this.subredditName, required this.subredditId});

  @override
  State<ModQueueWeb> createState() => _ModQueueWebState();
}

class _ModQueueWebState extends State<ModQueueWeb> {
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
                  screen: 'Mod queue',
                  subredditName: widget.subredditName,
                  subredditId: widget.subredditId),
              QueuesWidget(
                  screen: 'Mod Queue', subredditName: widget.subredditName)
            ],
          )),
    );
  }
}
