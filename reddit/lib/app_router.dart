import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/bloc/email_settings_bloc.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'presentation/screens/email_settings_web.dart';
import 'presentation/screens/home_page.dart';
import 'presentation/screens/safety_settings_web.dart';

class AppRouter {
  // declare repository and cubit objects
  late EmailSettingsReposity emailSettingsReposity;
  late EmailSettingsBloc emailSettingsBloc;

  AppRouter() {
    // initialise repository and cubit objects
    emailSettingsReposity = EmailSettingsReposity();
    emailSettingsBloc = EmailSettingsBloc(emailSettingsReposity);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/emailSettings':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: emailSettingsBloc,
                  child: const EmailSettingsWeb(userId: 1),
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
      default:
        return null;
    }
  }
}
