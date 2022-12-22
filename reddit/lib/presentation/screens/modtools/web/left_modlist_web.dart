import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';

class LeftModList extends StatefulWidget {
  String screen = '';
  final String subredditName;
  final String subredditId;
  LeftModList(
      {required this.screen,
      required this.subredditName,
      required this.subredditId,
      super.key});

  @override
  State<LeftModList> createState() => _LeftModListState();
}

class _LeftModListState extends State<LeftModList> {
  Widget leftListTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 8),
      child: InkWell(
          child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 5),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      )),
    );
  }

  Widget leftListElement(String title, String routeName) {
    return Row(
      children: [
        Container(
          color: widget.screen == title ? Colors.grey : Colors.transparent,
          width: 5,
          height: 35,
        ),
        Container(
          color: widget.screen == title
              ? Colors.grey.withOpacity(0.3)
              : Colors.transparent,
          width: 260,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, routeName,
                      arguments: {
                        'name': widget.subredditName,
                        'id': widget.subredditId
                      }),
              child: Row(children: [
                const SizedBox(width: 20),
                Text(title, style: const TextStyle(fontSize: 14))
              ])),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
      width: 280,
      height: MediaQuery.of(context).size.height - 40,
      color: defaultSecondaryColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------Queues-----------------------------------
            leftListTitle('QUEUES', Icons.queue_outlined),
            leftListElement('Mod queue', modqueueRoute),
            leftListElement('Spam', spamRoute),
            leftListElement('Edited', editedRoute),
            leftListElement('Unmoderated', unmoderatedRoute),
            const SizedBox(height: 40),
            //---------------------------USER MANAGEMENT-----------------------------------
            leftListTitle('USER MANAGEMENT', Icons.person_outline),
            leftListElement('Approved', approvedRoute),
            leftListElement('Moderators', moderatorsRoute),
            const SizedBox(height: 40),
            //---------------------------RULES AND REGULATIONS-----------------------------------
            leftListTitle('RULES AND REGULATIONS', Icons.list_alt),
            leftListElement('Rules', rulesRoute),
            const SizedBox(height: 40),
            //---------------------------OTHER-----------------------------------
            leftListTitle('OTHER', Icons.settings_outlined),
            leftListElement('Community settings', communitySettingsRoute),
            const SizedBox(height: 40),
            //---------------------------COMMUNITY ACTIVITY-----------------------------------
            leftListTitle(
                'COMMUNITY ACTIVITY', Icons.stacked_bar_chart_outlined),
            leftListElement('Traffic stats', tafficRoute),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
