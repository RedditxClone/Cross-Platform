import 'package:flutter/material.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/strings.dart';

class MessagesTabBar extends StatelessWidget {
  final int index;
  MessagesTabBar({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cardsColor,
      padding: EdgeInsets.fromLTRB(
          30,
          20,
          MediaQuery.of(context).size.width - 500 > 0
              ? MediaQuery.of(context).size.width - 500
              : 20,
          20),
      child: Row(children: [
        TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, messageScreenRoute),
            child: Text(
              'Send A Private Messge',
              style: TextStyle(
                  fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  color: index == 0 ? Colors.white : Colors.grey),
            )),
        const SizedBox(width: 30),
        TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, messageScreenRoute),
            child: Text(
              'Inbox',
              style: TextStyle(
                  fontWeight: index == 1 ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  color: index == 1 ? Colors.white : Colors.grey),
            )),
        const SizedBox(width: 30),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, sentRoute),
            child: Text(
              'Sent',
              style: TextStyle(
                  fontWeight: index == 2 ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  color: index == 2 ? Colors.white : Colors.grey),
            )),
      ]),
    );
  }
}
