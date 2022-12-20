import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/create_community_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/sort_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/create_community_repository.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';
import 'package:reddit/presentation/screens/create_community_screen.dart';
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
    return BlocBuilder<SortCubit, SortState>(
      builder: (context, state) {
        if (state is SortBest) {
          sortBy = 'best';
          BlocProvider.of<PostsHomeCubit>(context)
              .getTimelinePosts(sort: sortBy);
        } else if (state is SortNew) {
          sortBy = 'new';
          BlocProvider.of<PostsHomeCubit>(context)
              .getTimelinePosts(sort: sortBy);
        } else if (state is SortHot) {
          sortBy = 'hot';
          BlocProvider.of<PostsHomeCubit>(context)
              .getTimelinePosts(sort: sortBy);
        } else if (state is SortTop) {
          sortBy = 'top';
          BlocProvider.of<PostsHomeCubit>(context)
              .getTimelinePosts(sort: sortBy);
        }
        return Container(
          // sort posts
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: defaultSecondaryColor),
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SortCubit>(context).sort("best");
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
                      BlocProvider.of<SortCubit>(context).sort("new");
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
                      BlocProvider.of<SortCubit>(context).sort("hot");
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
                      BlocProvider.of<SortCubit>(context).sort("top");
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
      },
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
              'Create Post',
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

  void createCommunityDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => BlocProvider(
              create: (context) => CreateCommunityCubit(
                  CreateCommunityRepository(CreateCommunityWebServices())),
              child: const CreateCommunityScreen(),
            ));
  }

  Widget _createCommunity() {
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: () => UserData.isLoggedIn
            ? createCommunityDialog()
            : Navigator.pushNamed(context, loginPage),
        style: OutlinedButton.styleFrom(
            // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            side: const BorderSide(width: 1, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: const Text(
          "Create Community",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Widget _rightCard() {
    return Container(
      height: UserData.isLoggedIn ? 305 : 285,
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
                'assets/images/right_card_home.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                    child: Text(
                  'Your personal Reddit frontpage. Come here to check in with your favorite communities.',
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
                              children: [_rightCard()],
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
