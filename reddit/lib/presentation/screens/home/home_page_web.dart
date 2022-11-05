import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/screens/Home/home_web.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: defaultAppbarBackgroundColor,
            title: const AppBarWebLoggedIn(
              screen: 'Home',
            )),
        body: const HomeWeb(isLoggedIn: true));
  }
}
