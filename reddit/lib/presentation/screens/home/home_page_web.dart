import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/screens/Home/home_web.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class HomePageWeb extends StatefulWidget {
  final bool isLoggedIn;
  const HomePageWeb({Key? key, required this.isLoggedIn}) : super(key: key);

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
            title: widget.isLoggedIn
                ? const AppBarWebLoggedIn(screen: 'Home')
                : const AppBarWebNotLoggedIn(screen: 'Home')),
        body: HomeWeb(isLoggedIn: widget.isLoggedIn));
  }
}
