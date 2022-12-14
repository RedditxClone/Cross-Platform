import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_list_not_logged_in.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);
  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  late Responsive responsive;
  String sortBy = 'best';
  Widget _sortBy() {
    return Container(
      // sort posts
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by new
                  setState(() {
                    sortBy = 'best';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'best'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sortBy == 'best'
                        ? const Icon(Icons.rocket)
                        : const Icon(Icons.rocket_outlined),
                    const SizedBox(width: 5),
                    const Text(
                      'Best',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by new
                  setState(() {
                    sortBy = 'new';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'new'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sortBy == 'new'
                        ? const Icon(Icons.new_releases_sharp)
                        : const Icon(Icons.new_releases_outlined),
                    const SizedBox(width: 5),
                    const Text(
                      'New',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by hot
                  setState(() {
                    sortBy = 'hot';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'hot'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sortBy == 'hot'
                        ? const Icon(Icons.local_fire_department)
                        : const Icon(Icons.local_fire_department_outlined),
                    const SizedBox(width: 5),
                    const Text(
                      'Hot',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by top
                  setState(() {
                    sortBy = 'top';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'top'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.trending_up_rounded),
                    SizedBox(width: 5),
                    Text(
                      'Top',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

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
          !UserData.isLoggedIn && MediaQuery.of(context).size.width > 1300
              ? const LeftList()
              : const SizedBox(width: 0),
          SizedBox(
            width:
                UserData.isLoggedIn || MediaQuery.of(context).size.width < 1300
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
                      child: const SizedBox(width: 0)),
                  Expanded(
                    flex: responsive.isLargeSizedScreen()
                        ? 8
                        : responsive.isXLargeSizedScreen()
                            ? 6
                            : 7,
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
                          // sort posts
                          _sortBy(),
                          // -----------------------------------------------
                          // ---------------------POSTS---------------------
                          // -----------------------------------------------
                          BlocBuilder<PostsHomeCubit, PostsHomeState>(
                            builder: (context, state) {
                              if (state is PostsLoaded) {
                                return Column(children: [
                                  ...state.posts!
                                      .map((e) => PostsWeb(postsModel: e))
                                      .toList()
                                ]);
                              }
                              return Container();
                            },
                          ),
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
                      flex: responsive.isSmallSizedScreen() ||
                              responsive.isMediumSizedScreen()
                          ? 0
                          : responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: SizedBox(
                          width: responsive.isMediumSizedScreen() ? 15 : 0))
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
