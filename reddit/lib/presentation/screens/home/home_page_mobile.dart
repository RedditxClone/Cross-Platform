import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/end_drawer/end_drawer_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_popular_cubit.dart';
import 'package:reddit/data/repository/end_drawer/end_drawer_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/screens/test_home_screens/chat.dart';
import 'package:reddit/presentation/screens/test_home_screens/explore.dart';
import 'package:reddit/presentation/screens/test_home_screens/notifications.dart';
import 'package:reddit/presentation/widgets/home_widgets/end_drawer.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_drawer.dart';
import 'package:reddit/presentation/widgets/posts/add_post.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

import '../../../business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import '../../../business_logic/cubit/left_drawer/left_drawer_cubit.dart';
import '../../../constants/strings.dart';
import '../../../helper/utils/shared_keys.dart';
import '../../../helper/utils/shared_pref.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedPageIndex = 0;
  late String _screen;
  IconData dropDownArrow = Icons.keyboard_arrow_down;

  _HomePageState() {
    _selectedPageIndex = 0;
    _screen = 'Home';
  }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context)
        .getUserData(PreferenceUtils.getString(SharedPrefKeys.token));
  }

  Widget buildHomeAppBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        color: const Color.fromRGBO(90, 90, 90, 100),
        child: DropdownButton2(
            key: const Key('dropdown'),
            dropdownWidth: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            buttonHeight: 40,
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
            items: ['Home', 'Popular']
                .map((e) => DropdownMenuItem(
                      key: const Key('dropdown-item'),
                      value: e,
                      child: Row(
                        children: [
                          Icon(
                            e == 'Home'
                                ? Icons.home_filled
                                : Icons.arrow_circle_up_rounded,
                            key: e == 'Home'
                                ? const Key('Home-test')
                                : const Key('popular-test'),
                          ),
                          const SizedBox(width: 10),
                          Text(e),
                        ],
                      ),
                    ))
                .toList(),
            value: _screen,
            onChanged: (val) {
              setState(() {
                _screen = val as String;
              });
            }));
  }

  Map<String, Object> getPage(int index) {
    switch (index) {
      case 0:
        return {
          'page': _screen == 'Home'
              ? BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  BlocProvider.of<PostsHomeCubit>(context).getTimelinePosts();
                  if (state is Login ||
                      state is GetTheUserData ||
                      state is SignedIn) {
                    if (state is Login && state.userDataJson != {}) {
                      debugPrint("user is nottttttttttttttttttttttttt null");
                      UserData.initUser(state.userDataJson);
                      debugPrint("user is ${UserData.isLogged()}");
                      BlocProvider.of<LeftDrawerCubit>(context)
                          .getLeftDrawerData();

                      return homePosts();
                    } else if (state is GetTheUserData &&
                        state.userDataJson != {}) {
                      UserData.initUser(state.userDataJson);
                      BlocProvider.of<LeftDrawerCubit>(context)
                          .getLeftDrawerData();
                      return homePosts();
                    } else if (state is SignedIn && state.userDataJson != {}) {
                      BlocProvider.of<LeftDrawerCubit>(context)
                          .getLeftDrawerData();

                      return homePosts();
                    }
                  } else if (state is NotLoggedIn) {
                    return homePosts();
                  }
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                })
              : BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  BlocProvider.of<PostsPopularCubit>(context).getPopularPosts();
                  if (state is Login ||
                      state is GetTheUserData ||
                      state is SignedIn) {
                    if (state is Login && state.userDataJson != {}) {
                      debugPrint("user is nottttttttttttttttttttttttt null");
                      UserData.initUser(state.userDataJson);
                      debugPrint("user is ${UserData.isLogged()}");
                      BlocProvider.of<LeftDrawerCubit>(context)
                          .getLeftDrawerData();

                      return popularPosts();
                    } else if (state is GetTheUserData &&
                        state.userDataJson != {}) {
                      UserData.initUser(state.userDataJson);
                      BlocProvider.of<LeftDrawerCubit>(context)
                          .getLeftDrawerData();

                      return popularPosts();
                    } else if (state is SignedIn && state.userDataJson != {}) {
                      BlocProvider.of<LeftDrawerCubit>(context)
                          .getLeftDrawerData();

                      return popularPosts();
                    }
                  } else if (state is NotLoggedIn) {
                    return popularPosts();
                  }
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }),
          'appbar_title': Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(90, 90, 90, 100),
              borderRadius: BorderRadius.circular(5),
            ),
            child: buildHomeAppBar(),
          ),
          'appbar_action': IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchRouteWeb);
              },
              icon: const Icon(Icons.search_outlined,
                  color: Colors.grey, size: 40)),
        };
      case 1:
        return {
          'page': const Explore(),
          'appbar_title': const TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.grey),
          ),
          'appbar_action': const SizedBox(width: 1)
        };
      case 2:
        return {
          'page': const AddPost(),
          'appbar_title': const Text(""),
          'appbar_action': const SizedBox(width: 1)
        };
      case 3:
        return {
          'page': const Chat(),
          'appbar_title': const Text("", style: TextStyle(color: Colors.white)),
          'appbar_action': const Icon(Icons.add_comment_outlined)
        };
      case 4:
        return {
          'page': const Notifications(),
          'appbar_title': const Center(
            child: Text("Inbox", style: TextStyle(color: Colors.white)),
          ),
          'appbar_action':
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        };
      default:
        return {
          'page': Container(),
          'appbar_title': Container(),
          'appbar_action': Container()
        };
    }
  }

  void _switchpage(int index) {
    if (index == 2) {
      index = 0;
      Navigator.pushNamed(context, createPostScreenRoute);
    }
    setState(() {
      _selectedPageIndex = index;
    });
  }

  BottomNavigationBarItem bottomNavBarItem(
      int index, IconData iSelected, IconData iNotselected) {
    return BottomNavigationBarItem(
        icon: Icon((_selectedPageIndex == index) ? iSelected : iNotselected,
            size: 33),
        label: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //------------------------App Bar-------------------------//
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: const Color.fromRGBO(30, 30, 30, 100),
        title: getPage(_selectedPageIndex)['appbar_title'] as Widget,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          getPage(_selectedPageIndex)['appbar_action'] as Widget,
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Login ||
                  state is GetTheUserData ||
                  state is SignedIn ||
                  state is SignedInWithProfilePhoto) {
                return IconButton(
                  key: const Key('user-icon'),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: UserData.profileSettings!.profile.isEmpty
                      ? const Icon(
                          Icons.person,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                          UserData.user!.profilePic!,
                        )),
                );
              } else {
                return IconButton(
                    key: const Key('user-icon'),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const CircleAvatar(
                        child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 25,
                    )));
              }
            },
          )
        ],
      ),
      //--------------------------Body--------------------------//
      body: getPage(_selectedPageIndex)['page'] as Widget,
      //----------------Bottom Navigation Bar-------------------//
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _switchpage,
          items: [
            bottomNavBarItem(0, Icons.home, Icons.home_outlined),
            bottomNavBarItem(1, Icons.navigation, Icons.navigation_outlined),
            bottomNavBarItem(2, Icons.add, Icons.add),
            bottomNavBarItem(3, Icons.chat, Icons.chat_outlined),
            bottomNavBarItem(
                4, Icons.notifications, Icons.notifications_outlined),
          ]),
      drawer: LeftDrawer(),
      endDrawer: BlocProvider(
        create: (context) =>
            EndDrawerCubit(EndDrawerRepository(SettingsWebServices())),
        child: EndDrawer(
          2,
          35,
        ),
      ),
    );
  }

  Widget homePosts() {
    return BlocBuilder<PostsHomeCubit, PostsHomeState>(
      builder: (context, state) {
        if (state is PostsLoaded) {
          if (state.posts!.isNotEmpty) {
            return ListView(children: [
              ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
            ]);
          }
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    "assets/images/comments.jpg",
                    scale: 3,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Be the first to create a post",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Expanded(flex: 3, child: Container()),
                    const Expanded(
                      flex: 20,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "No posts are available yet. Create a post or join a community!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget popularPosts() {
    double cardHeight = 100;
    return BlocBuilder<PostsPopularCubit, PostsPopularState>(
      builder: (context, state) {
        if (state is PopularPostsLoaded) {
          if (state.posts!.isNotEmpty) {
            return ListView(
              children: [
                Column(
                  children: [
                    ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
                  ],
                ),
              ],
            );
          }
          return Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  "assets/images/comments.jpg",
                  scale: 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Be the first to create a post",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  Expanded(flex: 3, child: Container()),
                  const Expanded(
                    flex: 20,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "No posts are available yet. Create a post or join a community!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ]),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
