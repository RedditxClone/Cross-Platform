import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'presentation/screens/feed_setting.dart';

class AppRouter {
  // declare repository and cubit objects
  AppRouter() {
    // initialise repository and cubit objects
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(),
                  body: Container(),
                ));
      case feedSettingRoute:
        return MaterialPageRoute(builder: (_) => const FeedSetting());

      /*
      case example:
      case '/':
        return MaterialPageRoute(
          // create bloc at the the root of widget tree
          builder: (_) => BlocProvider(
            // we pass the cubit class to create
            create: (context) => CubitObject,
            // our child is the screen itself
            child: const Screen(),
          ),
        );
      */
      default:
        return null;
    }
  }
}
