import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/screens/modtools/web/left_modlist_web.dart';
import 'package:reddit/presentation/widgets/modtools/web/traffic_stats_widget.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class TrafficStatsWeb extends StatefulWidget {
  final String subredditName;
  final String subredditId;
  const TrafficStatsWeb(
      {super.key, required this.subredditName, required this.subredditId});

  @override
  State<TrafficStatsWeb> createState() => _TrafficStatsWebState();
}

class _TrafficStatsWebState extends State<TrafficStatsWeb> {
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
                  screen: 'Traffic stats',
                  subredditName: widget.subredditName,
                  subredditId: widget.subredditId),
              TrafficStatsWidget(
                  screen: 'Traffic stats', subredditName: widget.subredditName)
            ],
          )),
    );
  }
}
