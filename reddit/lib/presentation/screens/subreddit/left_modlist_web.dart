import 'dart:html';

import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';

class LeftModList extends StatefulWidget {
  String screen = '';
  LeftModList({required this.screen, super.key});

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

  Widget leftListElement(String title) {
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
              onTap: () => navigate(title),
              child: Row(children: [
                const SizedBox(width: 20),
                Text(title, style: const TextStyle(fontSize: 14))
              ])),
        ),
      ],
    );
  }

  navigate(String newTabName) {
    setState(() {
      widget.screen = newTabName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
      width: 280,
      color: defaultSecondaryColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------Queues-----------------------------------
            leftListTitle('QUEUES', Icons.queue_outlined),
            leftListElement('Mod queue'),
            leftListElement('Spam'),
            leftListElement('Edited'),
            leftListElement('Unmoderated'),
            const SizedBox(height: 40),
            //---------------------------USER MANAGEMENT-----------------------------------
            leftListTitle('USER MANAGEMENT', Icons.person_outline),
            leftListElement('Muted'),
            leftListElement('Approved'),
            leftListElement('Moderators'),
            const SizedBox(height: 40),
            //---------------------------RULES AND REGULATIONS-----------------------------------
            leftListTitle('RULES AND REGULATIONS', Icons.list_alt),
            leftListElement('Rules'),
            leftListElement('Removal reasons'),
            leftListElement('Content controls'),
            leftListElement('Auto mod'),
            const SizedBox(height: 40),
            //---------------------------OTHER-----------------------------------
            leftListTitle('OTHER', Icons.settings_outlined),
            leftListElement('Community settings'),
            const SizedBox(height: 40),
            //---------------------------COMMUNITY ACTIVITY-----------------------------------
            leftListTitle(
                'COMMUNITY ACTIVITY', Icons.stacked_bar_chart_outlined),
            leftListElement('Traffic stats'),
            leftListElement('Mod log'),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
