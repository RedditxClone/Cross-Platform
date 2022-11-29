import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/screens/create_community_screen.dart';
import 'package:reddit/presentation/widgets/nav_bars/popup_menu_logged_in.dart';

class AppBarWebLoggedIn extends StatefulWidget {
  final String screen;
  final User user;
  const AppBarWebLoggedIn({Key? key, required this.screen, required this.user})
      : super(key: key);

  @override
  State<AppBarWebLoggedIn> createState() => _AppBarWebLoggedInState();
}

class _AppBarWebLoggedInState extends State<AppBarWebLoggedIn> {
  void createCommunityDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const CreateCommunityScreen());
  }

  void routeToPage(val) {
    switch (val) {
      case 'Home':
        Navigator.pushNamed(context, homePageRoute, arguments: widget.user);
        break;
      case 'Popular':
        Navigator.pushNamed(context, popularPageRoute, arguments: widget.user);
        break;
      case 'Create Community':
        createCommunityDialog();
        break;
      case 'User settings':
        Navigator.pushNamed(context, settingsTabsRoute);
        break;
      default:
    }
  }

  List<DropdownMenuItem<String>> createItems(BuildContext context) {
    return [
      const DropdownMenuItem(
          enabled: false,
          child: Text('FEEDS',
              style: TextStyle(fontSize: 12, color: Colors.grey))),
      DropdownMenuItem(
          value: 'Home',
          child: Row(children: [
            const Icon(Icons.home_filled, size: 20),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('Home', style: TextStyle(fontSize: 15))
          ])),
      DropdownMenuItem(
          key: const Key('popular-test'),
          value: 'Popular',
          child: Row(children: [
            const Icon(Icons.arrow_circle_up_outlined, size: 20),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('Popular', style: TextStyle(fontSize: 15))
          ])),
      DropdownMenuItem(
          value: 'All',
          child: Row(children: [
            const FaIcon(FontAwesomeIcons.chartBar, size: 20),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('All', style: TextStyle(fontSize: 15))
          ])),
      //
      const DropdownMenuItem(
          enabled: false,
          child: Text('YOUR COMMUNITIES',
              style: TextStyle(fontSize: 12, color: Colors.grey))),
      DropdownMenuItem(
          value: 'Create Community',
          child: Row(children: [
            const Icon(Icons.add, size: 20),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('Create Community', style: TextStyle(fontSize: 15))
          ])),
      //
      const DropdownMenuItem(
          enabled: false,
          child: Text('OTHER',
              style: TextStyle(fontSize: 12, color: Colors.grey))),
      DropdownMenuItem(
          key: const Key('user-settings-test'),
          value: 'User settings',
          child: Row(children: [
            const CircleAvatar(radius: 13, child: Icon(Icons.person, size: 15)),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('User Settings', style: TextStyle(fontSize: 15))
          ])),
      DropdownMenuItem(
          value: 'Messages',
          child: Row(children: [
            const CircleAvatar(radius: 13, child: Icon(Icons.person, size: 15)),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('Messages', style: TextStyle(fontSize: 15))
          ])),
      DropdownMenuItem(
          value: 'u/user_name',
          child: Row(children: [
            const CircleAvatar(radius: 13, child: Icon(Icons.person, size: 15)),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('u/user_name', style: TextStyle(fontSize: 15))
          ])),
      DropdownMenuItem(
          value: 'Create Post',
          child: Row(children: [
            const Icon(Icons.add, size: 20),
            const SizedBox(width: 8),
            MediaQuery.of(context).size.width < 930
                ? const SizedBox(width: 0)
                : const Text('Create Post', style: TextStyle(fontSize: 15))
          ])),
    ];
  }

  Widget appBardIcon(IconData icon, Function func) {
    return InkWell(
      onTap: () => func,
      child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 25,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, homePageRoute),
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Logo(Logos.reddit, color: Colors.white, size: 28)),
              const SizedBox(width: 10),
              MediaQuery.of(context).size.width < 940
                  ? const SizedBox(width: 0)
                  : const Text('reddit'),
            ],
          ),
        ),
        DropdownButton2(
            key: const Key('dropdown'),
            alignment: Alignment.center,
            buttonHeight: 40,
            buttonWidth: 0.17 * MediaQuery.of(context).size.width,
            buttonPadding: const EdgeInsets.only(left: 10),
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
            items: createItems(context),
            value: widget.screen,
            onChanged: (val) {
              routeToPage(val);
            }),
        SizedBox(
          key: const Key('search-bar'),
          width: 0.25 * MediaQuery.of(context).size.width,
          height: 40,
          child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromRGBO(50, 50, 50, 100)),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                filled: true,
                hintText: "Search Reddit",
                isDense: true,
                hoverColor: const Color.fromRGBO(70, 70, 70, 100),
                fillColor: const Color.fromRGBO(50, 50, 50, 100),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 25,
                ),
              )),
        ),
        Row(children: [
          MediaQuery.of(context).size.width < 740
              ? const SizedBox(width: 0)
              : Row(children: [
                  appBardIcon(Icons.arrow_circle_up_rounded, () {
                    Navigator.pushReplacementNamed(context, popularPageRoute);
                  }),
                  appBardIcon(Icons.circle_outlined, () {}),
                  appBardIcon(Icons.chat, () {}),
                  Container(
                      height: 30,
                      width: 1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey))),
                ]),
          Row(
            children: [
              appBardIcon(Icons.shield_outlined, () {}),
              appBardIcon(Icons.message_outlined, () {}),
              appBardIcon(Icons.notifications_outlined, () {}),
              appBardIcon(Icons.add, () {}),
            ],
          ),
        ]),
        MediaQuery.of(context).size.width < 520
            ? const SizedBox(width: 0)
            : PopupMenuLoggedIn(
                user: widget.user,
              ),
      ],
    );
  }
}
