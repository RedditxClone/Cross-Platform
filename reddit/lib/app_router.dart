import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/screens/profile_settings_screen.dart';
import 'package:reddit/presentation/screens/profile_settings_web.dart';

class AppRouter {
  // declare repository and cubit objects
  late SettingsRepository settingsRepository;
  late SettingsCubit settingsCubit;
  AppRouter() {
    // initialise repository and cubit objects
    settingsRepository = SettingsRepository(SettingsWebServices());
    settingsCubit = SettingsCubit(settingsRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Scaffold(
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
      case profileSettingsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => settingsCubit,
                  child: kIsWeb
                      ? const ProfileSettingsWeb()
                      : const ProfileSettings(),
                ));
    }
  }
}
