import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';

class LeftModList extends StatelessWidget {
  const LeftModList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 280,
      color: defaultSecondaryColor,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //---------------------------Queues-----------------------------------
                  InkWell(
                      child: Row(
                    children: const [
                      Icon(Icons.library_books_outlined, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('QUEUES',
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  )),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, homePageRoute,
                              arguments: null);
                        },
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Mod queue', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Spam', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Edited', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Unmoderated', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 40),
                  //---------------------------USER MANAGEMENT-----------------------------------

                  InkWell(
                      child: Row(
                    children: const [
                      Icon(Icons.person_outline, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('USER MANAGEMENT',
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  )),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Muted', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Approved', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Moderators', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 40),
                  //---------------------------RULES AND REGULATIONS-----------------------------------
                  InkWell(
                      child: Row(
                    children: const [
                      Icon(Icons.list_alt, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('RULES AND REGULATIONS',
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  )),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Rules', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Removal reasons',
                              style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Content controls',
                              style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Auto mod', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 40),
                  //---------------------------OTHER-----------------------------------
                  InkWell(
                      child: Row(
                    children: const [
                      Icon(Icons.settings_outlined, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('OTHER',
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  )),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Community settings',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(width: 40),
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                        ])),
                  ),

                  const SizedBox(height: 40),
                  //---------------------------COMMUNITY ACTIVITY-----------------------------------
                  InkWell(
                      child: Row(
                    children: const [
                      Icon(Icons.stacked_bar_chart, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('COMMUNITY ACTIVITY',
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  )),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Traffic stats', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Text('Mod log', style: TextStyle(fontSize: 16))
                        ])),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
