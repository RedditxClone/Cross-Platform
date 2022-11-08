import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_list_not_logged_in.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class HomeWeb extends StatefulWidget {
  final bool isLoggedIn;
  const HomeWeb({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  late Responsive responsive;
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return
        //SingleChildScrollView(
        //child:
        Container(
      color: defaultWebBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if user is signed in dont display left list
          !widget.isLoggedIn && MediaQuery.of(context).size.width > 1300
              ? const LeftList()
              : const SizedBox(width: 0),
          Container(
            width: widget.isLoggedIn
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 280,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: responsive.isSmallSizedScreen() |
                              responsive.isMediumSizedScreen()
                          ? 0
                          : responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: const SizedBox(width: 10)),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: 10,
                      child: Column(
                        children: [
                          Container(
                            // add new post
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(70, 70, 70, 100)),
                            height: 70,
                            margin: const EdgeInsets.only(bottom: 15),
                          ),
                          Container(
                            // sort posts
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(70, 70, 70, 100)),
                            margin: const EdgeInsets.only(bottom: 15),
                          ),
                          PostsWeb(),
                          PostsWeb(),
                          PostsWeb(),
                          PostsWeb(),
                        ],
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width < 900
                      ? const SizedBox(width: 0)
                      : Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          70, 70, 70, 100)),
                                  margin: const EdgeInsets.only(bottom: 15),
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          70, 70, 70, 100)),
                                  margin: const EdgeInsets.only(bottom: 15),
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          70, 70, 70, 100)),
                                  margin: const EdgeInsets.only(bottom: 15),
                                ),
                              ],
                            ),
                          )),
                  Expanded(
                      flex: responsive.isSmallSizedScreen() |
                              responsive.isMediumSizedScreen()
                          ? 0
                          : responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: const SizedBox(width: 10))
                ],
              ),
            ),
          )
        ],
      ),
      //),
    );
  }
}
