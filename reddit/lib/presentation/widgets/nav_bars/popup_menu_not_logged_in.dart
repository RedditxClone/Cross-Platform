import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

class PopupMenuNotLoggedIn extends StatelessWidget {
  const PopupMenuNotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> optionsList = [
      PopupMenuItem(
          value: 0,
          child: Row(
            children: const [
              SizedBox(width: 10),
              Icon(Icons.help),
              SizedBox(width: 10),
              Text(
                'Help center',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              SizedBox(width: 10),
              Icon(Icons.login),
              SizedBox(width: 10),
              Text(
                'Log In/Sign Up',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
    ];
    return PopupMenuButton(
      padding: const EdgeInsets.all(0),
      offset: Offset.fromDirection(0, 150),
      position: PopupMenuPosition.under,
      itemBuilder: (_) => optionsList,
      constraints: const BoxConstraints.expand(width: 200, height: 130),
      onSelected: (value) {
        switch (value) {
          case 3:
            //sNavigator.pushReplacementNamed(context, profileSettingsRoute);
            break;
          default:
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.1))),
        child: Row(
          children: const [
            Icon(
              Icons.person,
              size: 30,
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_downward),
          ],
        ),
      ),
    );
  }
}
