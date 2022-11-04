import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

class PopupMenuLoggedIn extends StatelessWidget {
  const PopupMenuLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> optionsList = [
      PopupMenuItem(
          enabled: false,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Icon(Icons.person_outline_rounded),
            SizedBox(width: 5),
            Text(
              'My Stuff',
              style: TextStyle(fontSize: 17),
            )
          ])),
      PopupMenuItem(
          value: 0,
          child: Row(
            children: const [
              SizedBox(width: 20),
              Text(
                'Online status',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              SizedBox(width: 20),
              Text(
                'Profile',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      PopupMenuItem(
          value: 2,
          child: Row(
            children: const [
              SizedBox(width: 20),
              Text(
                'Style avatar',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      PopupMenuItem(
          value: 3,
          child: Row(
            children: const [
              SizedBox(width: 20),
              Text(
                'User Settings',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      PopupMenuItem(
          value: 4,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Icon(Icons.circle),
            SizedBox(width: 5),
            Text(
              'Create a community',
              style: TextStyle(fontSize: 15),
            )
          ])),
      PopupMenuItem(
          value: 5,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Icon(Icons.circle_outlined),
            SizedBox(width: 5),
            Text(
              'Talk',
              style: TextStyle(fontSize: 15),
            )
          ])),
      PopupMenuItem(
          value: 6,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Icon(Icons.logout_outlined),
            SizedBox(width: 5),
            Text(
              'Logout',
              style: TextStyle(fontSize: 15),
            )
          ])),
      PopupMenuItem(
          enabled: false,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Expanded(
              child: Text(
                '© 2022 Redditx, Inc. All rights reserved',
                style: TextStyle(fontSize: 11),
              ),
            )
          ])),
    ];
    return PopupMenuButton(
      padding: const EdgeInsets.all(0),
      offset: Offset.fromDirection(0, 150),
      position: PopupMenuPosition.under,
      itemBuilder: (_) => optionsList,
      constraints: const BoxConstraints.expand(width: 200, height: 450),
      onSelected: (value) {
        switch (value) {
          case 3:
            Navigator.pushReplacementNamed(context, profileSettingsRoute);
            break;
          default:
            break;
        }
      },
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(width: 10),
          MediaQuery.of(context).size.width < 950
              ? const SizedBox(width: 0)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('user_name', style: TextStyle(fontSize: 15)),
                    Text('karma', style: TextStyle(fontSize: 10)),
                  ],
                )
        ],
      ),
    );
  }
}
