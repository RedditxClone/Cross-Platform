import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/business_logic/cubit/create_community_cubit.dart';
import 'package:reddit/business_logic/cubit/subreddit_page_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
// import 'package:reddit/data/model/signin.dart';
import 'package:reddit/data/repository/create_community_repository.dart';
import 'package:reddit/data/repository/subreddit_page_repository.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';
import 'package:reddit/data/web_services/subreddit_page_web_services.dart';
import 'package:reddit/presentation/screens/create_community_screen.dart';
import 'package:reddit/presentation/screens/subreddit_screen.dart';
import 'package:reddit/presentation/widgets/nav_bars/popup_menu_logged_in.dart';

class AppBarWebLoggedIn extends StatefulWidget {
  final String screen;
  const AppBarWebLoggedIn({Key? key, required this.screen}) : super(key: key);

  @override
  State<AppBarWebLoggedIn> createState() => _AppBarWebLoggedInState();
}

class _AppBarWebLoggedInState extends State<AppBarWebLoggedIn> {
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

  void routeToPage(val) {
    switch (val) {
      case 'Home':
        Navigator.pushNamed(context, homePageRoute);
        break;
      case 'Popular':
        Navigator.pushNamed(context, popularPageRoute);
        break;
      case 'Messages':
        Navigator.pushNamed(context, sendMessageRoute, arguments: '');
        break;
      case 'Create Community':
        createCommunityDialog();
        break;
      case 'r/subreddit':
        Navigator.pushNamed(context, subredditPageScreenRoute);
        break;
      case 'User settings':
        Navigator.pushNamed(context, settingsTabsRoute);
        break;
      default:
    }
  }

  DropdownMenuItem<String> dropDownMenuTitle(String title) {
    return DropdownMenuItem(
        enabled: false,
        child: Text(title,
            style: const TextStyle(fontSize: 12, color: Colors.grey)));
  }

  DropdownMenuItem<String> dropDownMenuItem(String title, IconData icon,
      {String imgUrl = ''}) {
    return DropdownMenuItem(
        value: title,
        key: Key(title),
        child: Row(children: [
          imgUrl == ''
              ? Icon(icon, size: 20)
              : CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    imgUrl,
                  )),
          const SizedBox(width: 8),
          MediaQuery.of(context).size.width < 930
              ? const SizedBox(width: 0)
              : Text(title, style: const TextStyle(fontSize: 15))
        ]));
  }

  List<DropdownMenuItem<String>> createItems(BuildContext context) {
    return [
      dropDownMenuTitle('YOUR COMMUNITIES'),
      dropDownMenuItem('Create Community', Icons.add),
      dropDownMenuItem('r/subreddit', Icons.person, imgUrl: ''),

      dropDownMenuTitle('FEEDS'),
      dropDownMenuItem('Home', Icons.home_filled),
      dropDownMenuItem('Popular', Icons.arrow_circle_up_outlined),
      // dropDownMenuItem('All',FontAwesomeIcons.chartBar),

      dropDownMenuTitle('FOLLOWING'),
      dropDownMenuItem('u/user_name', Icons.person, imgUrl: ''),

      dropDownMenuTitle('OTHER'),
      dropDownMenuItem('User settings', Icons.person,
          imgUrl: UserData.user!.profilePic!),
      dropDownMenuItem('Messages', Icons.person,
          imgUrl: UserData.user!.profilePic!),
      dropDownMenuItem('Create Post', Icons.add),
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
        Container(
          decoration: BoxDecoration(
            color: defaultAppbarBackgroundColor,
          ),
          child: DropdownButton2(
              dropdownDecoration: const BoxDecoration(
                color: Color.fromRGBO(30, 30, 30, 1),
              ),
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
        ),
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
            : const PopupMenuLoggedIn(),
      ],
    );
  }
}
