import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';

class LeftList extends StatelessWidget {
  const LeftList({Key? key}) : super(key: key);

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
                  //---------------------------feeds-----------------------------------
                  const InkWell(
                      child: Text('Feeds',
                          style: TextStyle(fontSize: 15, color: Colors.grey))),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, homePageRoute);
                        },
                        child: Row(children: const [
                          Icon(Icons.home_filled, size: 20),
                          SizedBox(width: 8),
                          Text('Home', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, popularPageRoute,
                              arguments: null);
                        },
                        child: Row(children: const [
                          Icon(Icons.arrow_circle_up_outlined, size: 20),
                          SizedBox(width: 8),
                          Text('Popular', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          FaIcon(FontAwesomeIcons.chartBar, size: 20),
                          SizedBox(width: 8),
                          Text('All', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 30),
                  //---------------------------other-----------------------------------

                  const InkWell(
                      child: Text('Other',
                          style: TextStyle(fontSize: 12, color: Colors.grey))),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          Icon(Icons.add, size: 20),
                          SizedBox(width: 8),
                          Text('Create Post', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 30),
                  //---------------------------topics-----------------------------------
                  const InkWell(
                      child: Text('Topics',
                          style: TextStyle(fontSize: 15, color: Colors.grey))),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          FaIcon(FontAwesomeIcons.gamepad, size: 20),
                          SizedBox(width: 8),
                          Text('Games', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          Icon(Icons.sports_tennis, size: 20),
                          SizedBox(width: 8),
                          Text('Sports', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          FaIcon(FontAwesome.chart_column, size: 20),
                          SizedBox(width: 8),
                          Text('Business', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          Icon(Icons.hexagon_outlined, size: 20),
                          SizedBox(width: 8),
                          Text('Crypto', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Row(children: const [
                          Icon(Icons.tv, size: 20),
                          SizedBox(width: 8),
                          Text('Television', style: TextStyle(fontSize: 17))
                        ])),
                  ),
                  const SizedBox(height: 17),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Create an account to follow your favorite communities and start taking part in conversations.',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, SIGNU_PAGE1),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 80),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      "Join Reddit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // const Expanded(child: SizedBox(height: 10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
