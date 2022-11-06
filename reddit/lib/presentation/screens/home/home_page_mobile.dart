import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:reddit/presentation/screens/home/home.dart';
import 'package:reddit/presentation/screens/popular/popular.dart';
import 'package:reddit/presentation/screens/test_home_screens/chat.dart';
import 'package:reddit/presentation/screens/test_home_screens/explore.dart';
import 'package:reddit/presentation/screens/test_home_screens/notifications.dart';
import 'package:reddit/presentation/widgets/home_widgets/end_drawer.dart';
import 'package:reddit/presentation/widgets/posts/add_post.dart';

class HomePage extends StatefulWidget {
  late bool _isLoggedin;
  final Object? arguments;
  HomePage(this.arguments, {Key? key}) : super(key: key) {
    Map<String, bool> argMap = arguments as Map<String, bool>;
    _isLoggedin = argMap["isLoggedin"] ?? false;
  }

  @override
  State<HomePage> createState() => _HomePageState(_isLoggedin);
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;
  String _screen = 'Home';
  IconData dropDownArrow = Icons.keyboard_arrow_down;
  bool passwordVisible = true;
  late bool _isLoggedin;
  _HomePageState(this._isLoggedin);
  void togglePasswordVisible() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
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
          'page': _screen == 'Home' ? const Home() : const Popular(),
          'appbar_title': Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(90, 90, 90, 100),
              borderRadius: BorderRadius.circular(5),
            ),
            child: buildHomeAppBar(),
          ),
          'appbar_action': IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.grey, size: 40)),
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
                icon: const Icon(Icons.person, color: Colors.grey, size: 40));
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
      drawer: const Drawer(),
      endDrawer: EndDrawer(_isLoggedin),
    );
  }
}
