import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/recaptcha_screen.dart'
    if (dart.library.html) 'package:reddit/presentation/screens/recaptcha_screen_web.dart'
    as recaptcha_screen;

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
      case recaptchaRoute:
        // return MaterialPageRoute(builder: (_) => const RecaptchaScreenWeb());
        return MaterialPageRoute(
            builder: (_) => const recaptcha_screen.RecaptchaScreen());
      default:
        return null;
    }
  }
}
