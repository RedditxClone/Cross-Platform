import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/end_drawer/end_drawer_cubit.dart';
import 'package:reddit/data/repository/end_drawer/end_drawer_repository.dart';
import 'package:reddit/data/repository/left_drawer/left_drawer_repository.dart';
import 'package:reddit/data/web_services/left_drawer/left_drawer_web_services.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/screens/home/home.dart';
import 'package:reddit/presentation/screens/home/home_not_loggedin_mobile.dart';
import 'package:reddit/presentation/screens/popular/popular.dart';
import 'package:reddit/presentation/screens/test_home_screens/chat.dart';
import 'package:reddit/presentation/screens/test_home_screens/explore.dart';
import 'package:reddit/presentation/screens/test_home_screens/notifications.dart';
import 'package:reddit/presentation/widgets/home_widgets/end_drawer.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_drawer.dart';
import 'package:reddit/presentation/widgets/posts/add_post.dart';

import '../../../business_logic/cubit/left_drawer/left_drawer_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage( {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  int _selectedPageIndex = 0;
  String _screen = 'Home';
  IconData dropDownArrow = Icons.keyboard_arrow_down;
  late bool isLoggedin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedin = UserData.user != null;
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
              ? isLoggedin
                  ? const Home()
                  : const HomeNotLoggedIn()
              : const Popular(),
          'appbar_title': Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(90, 90, 90, 100),
              borderRadius: BorderRadius.circular(5),
            ),
            child: buildHomeAppBar(),
          ),
          'appbar_action': IconButton(
              onPressed: () {},
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
          Builder(builder: (context) {
            return IconButton(
                key: const Key('user-icon'),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CircleAvatar(
                    child: isLoggedin && UserData.user!.profilePic != null
                        ? Image.network(
                            UserData.user!.profilePic!,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.person,
                            color: isLoggedin && UserData.user!.profilePic == null
                                ? Colors.orange
                                : Colors.grey,
                            size: 25)));
          })
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
      drawer: BlocProvider(
        create: (context) =>
            LeftDrawerCubit(LeftDrawerRepository(LeftDrawerWebServices())),
        child: LeftDrawer(isLoggedin),
      ),
      endDrawer: BlocProvider(
        create: (context) =>
            EndDrawerCubit(EndDrawerRepository(SettingsWebServices())),
        child: EndDrawer(
            isLoggedin,
            UserData.user == null ? "" : UserData.user!.name ?? "",
            UserData.user == null ? "" : UserData.user!.profilePic ?? "",
            2,
            35,
            true,
            UserData.user == null ? "" : UserData.user!.email ?? ""),
      ),
    );
  }
}
