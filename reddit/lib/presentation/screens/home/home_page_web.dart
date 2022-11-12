import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/signin.dart';
import 'package:reddit/presentation/screens/home/home_web.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class HomePageWeb extends StatefulWidget {
  User? user;
  HomePageWeb(this.user, {Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState(user: user);
}

class _HomePageWebState extends State<HomePageWeb> {
  late bool isLoggedIn;
  User? user;
  _HomePageWebState({required this.user});
  @override
  void initState() {
    super.initState();
    isLoggedIn = user != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5)),
            automaticallyImplyLeading: false,
            backgroundColor: defaultAppbarBackgroundColor,
            title: isLoggedIn
                ? AppBarWebLoggedIn(user: user!, screen: 'Home')
                : const AppBarWebNotLoggedIn(screen: 'Home')),
        body: HomeWeb(isLoggedIn: isLoggedIn));
  }
}
