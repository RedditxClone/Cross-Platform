import 'package:flutter/material.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/strings.dart';

class SavedTabBar extends StatelessWidget {
  final int index;
  SavedTabBar({required this.index, super.key});

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
                Navigator.pushReplacementNamed(context, savedPostsRoute),
            child: Text(
              'Saved Posts ',
              style: TextStyle(
                  fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  color: index == 0 ? Colors.white : Colors.grey),
            )),
        const SizedBox(width: 30),
        TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, savedPostsRoute),
            child: Text(
              'Saved Comments ',
              style: TextStyle(
                  fontWeight: index == 1 ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  color: index == 1 ? Colors.white : Colors.grey),
            )),
      ]),
    );
  }
}
