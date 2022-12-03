import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/create_community_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/create_community_repository.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';
import 'package:reddit/presentation/screens/create_community_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupMenuLoggedIn extends StatelessWidget {
  PopupMenuLoggedIn({Key? key}) : super(key: key);
  Future<void> _launchUrl(String link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void createCommunityDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (_) => BlocProvider(
              create: (context) => CreateCommunityCubit(
                  CreateCommunityRepository(CreateCommunityWebServices())),
              child: const CreateCommunityScreen(),
            ));
  }

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
      const PopupMenuDivider(),
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
          child: Row(
            children: const [
              Icon(Icons.help_outline_sharp),
              SizedBox(width: 10),
              Text(
                'Help center',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      const PopupMenuDivider(),
      PopupMenuItem(
          key: const Key('loggout'),
          value: 7,
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
      color: defaultSecondaryColor,
      key: const Key('popup-menu'),
      padding: const EdgeInsets.all(0.4),
      offset: Offset.fromDirection(0, 150),
      position: PopupMenuPosition.under,
      itemBuilder: (_) => optionsList,
      constraints: const BoxConstraints.expand(width: 230, height: 530),
      onSelected: (value) {
        switch (value) {
          case 1:
            Navigator.pushNamed(context, profilePageRoute);
            break;
          case 3:
            Navigator.pushNamed(context, settingsTabsRoute);
            break;
          case 4:
            createCommunityDialog(context);
            break;
          case 6:
            _launchUrl('https://www.reddithelp.com/hc/en-us');
            break;
          default:
            break;
        }
      },
      child: Row(
        children: [
          CircleAvatar(
              child: UserData.user!.profilePic == null ||
                      UserData.user!.profilePic == ''
                  ? const Icon(Icons.person)
                  : Image.network(UserData.user!.profilePic!,
                      fit: BoxFit.cover)),
          const SizedBox(width: 10),
          MediaQuery.of(context).size.width < 950
              ? const SizedBox(width: 0)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(UserData.user!.name!,
                        style: const TextStyle(fontSize: 15)),
                    const Text('karma', style: TextStyle(fontSize: 10)),
                  ],
                )
        ],
      ),
    );
  }
}
