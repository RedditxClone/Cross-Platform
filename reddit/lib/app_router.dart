import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/choose_screen_android.dart';
import 'package:reddit/presentation/screens/forget_password_android.dart';
import 'package:reddit/presentation/screens/forget_password_web.dart';
import 'package:reddit/presentation/screens/forget_username_android.dart';
import 'package:reddit/presentation/screens/forget_username_web.dart';
import 'package:reddit/presentation/screens/home.dart';
import 'package:reddit/presentation/screens/intesrests_android.dart';
import 'package:reddit/presentation/screens/login_page.dart';
import 'package:reddit/presentation/screens/login_screen.dart';
import 'package:reddit/presentation/screens/signup_page.dart';
import 'package:reddit/presentation/screens/signup_page2.dart';
import 'package:reddit/presentation/screens/signup_screen.dart';

import 'data/model/signin.dart';

class AppRouter {
  // declare repository and cubit objects
  AppRouter() {
    // initialise repository and cubit objects
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const InteresetesAndroid(),
        );
      case HOME_PAGE:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => Home(user: user),
        );
      case SIGNU_PAGE2:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => SignupWeb2(user: user),
        );
      case forgetUsernameWeb:
        return MaterialPageRoute(
          builder: (_) => const ForgetUsernameWeb(),
        );
      case forgetPasswordWeb:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordWeb(),
        );
      case SIGNU_PAGE1:
        return MaterialPageRoute(
          builder: (_) => const SignupWeb(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => const LoginWeb(),
        );
      case signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignupMobile(),
        );
      case forgetPasswordAndroid:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordAndroid(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginMobile(),
        );
        case forgetUsernameAndroid:
        return MaterialPageRoute(
          builder: (_) => const ForgetUsernameAndroid(),
        );
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
