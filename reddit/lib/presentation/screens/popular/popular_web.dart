import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_list_not_logged_in.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

import '../../../business_logic/cubit/posts/posts_home_cubit.dart';

class PopularWeb extends StatefulWidget {
  PopularWeb({Key? key}) : super(key: key);

  @override
  State<PopularWeb> createState() => _PopularWebState();
}

class _PopularWebState extends State<PopularWeb> {
  late Responsive responsive;
  late bool isLoggedIn;
  _PopularWebState();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostsHomeCubit>(context).getTimelinePosts();
    isLoggedIn = UserData.user != null;
  }

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

  Widget _createPost() {
    return Container(
      width: double.infinity,
      height: 53,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {}, // TODO : navigate to add new post
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(0.0)),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 70.0, minHeight: 20.0),
            alignment: Alignment.center,
            child: const Text(
              'Create post',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createCommunity() {
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(createCommunityScreenRoute),
        style: OutlinedButton.styleFrom(
            // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            side: const BorderSide(width: 1, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: const Text(
          "Create community",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Widget _rightCard() {
    return Container(
      height: 360,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: defaultSecondaryColor.withOpacity(0.85)),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/right_card.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                    child: Text(
                  'The best posts on Reddit for you, pulled from the most active communities on Reddit. Check here to see the most shared, upvoted, and commented content on the internet.',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white.withOpacity(0.8)),
                )),
                Divider(),
                _createPost(),
                _createCommunity()
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return Scaffold(
        appBar: AppBar(
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.3)),
            automaticallyImplyLeading: false,
            backgroundColor: defaultAppbarBackgroundColor,
            title: isLoggedIn
                ? const AppBarWebLoggedIn(screen: 'Popular')
                : const AppBarWebNotLoggedIn(screen: 'Popular')),
        body: Container(
          color: defaultWebBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isLoggedIn && MediaQuery.of(context).size.width > 1300
                  ? const LeftList()
                  : const SizedBox(width: 0),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: isLoggedIn || MediaQuery.of(context).size.width < 1300
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
                              : 1,
                          child: const SizedBox(width: 10)),
                      Expanded(
                        flex: responsive.isLargeSizedScreen()
                            ? 8
                            : responsive.isXLargeSizedScreen()
                                ? 6
                                : 7,
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      width: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20),
                                          const Text('Popular posts',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          SizedBox(height: 10),
                                          _sortBy(),
                                          BlocBuilder<PostsHomeCubit,
                                              PostsHomeState>(
                                            builder: (context, state) {
                                              if (state is PostsLoaded) {
                                                return Column(children: [
                                                  ...state.posts!
                                                      .map((e) => PostsWeb(
                                                          postsModel: e))
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
                                  const SizedBox(width: 15),
                                  MediaQuery.of(context).size.width < 1000
                                      ? const SizedBox(width: 0)
                                      : Expanded(
                                          flex: 3,
                                          child: Column(
                                            // there are the right cards
                                            children: [_rightCard()],
                                          )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: responsive.isSmallSizedScreen() |
                                  responsive.isMediumSizedScreen()
                              ? 0
                              : 1,
                          child: SizedBox(
                              width: responsive.isSmallSizedScreen() ? 0 : 10))
                    ],
                  ),
                ),
              ),
            ],
          ),
          // ),
        ));
  }
}
