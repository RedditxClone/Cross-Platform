import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';
import 'package:reddit/presentation/screens/home/home_page_mobile.dart';
import 'package:reddit/presentation/screens/home/home_page_web.dart';
import 'package:reddit/presentation/screens/popular/popular.dart';
import 'package:reddit/presentation/screens/popular/popular_web.dart';
import 'package:reddit/presentation/screens/safety_settings_web.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/screens/profile_settings_screen.dart';
import 'package:reddit/presentation/screens/profile_settings_web.dart';

class AppRouter {
  // declare repository and cubit objects
  late SafetySettingsRepository safetySettingsRepository;
  late SafetySettingsCubit safetySettingsCubit;
  late SettingsRepository settingsRepository;
  late SettingsCubit settingsCubit;
  AppRouter() {
    // initialise repository and cubit objects
    safetySettingsRepository =
        SafetySettingsRepository(SafetySettingsWebServices());
    safetySettingsCubit = SafetySettingsCubit(safetySettingsRepository);
    settingsRepository = SettingsRepository(SettingsWebServices());
    settingsCubit = SettingsCubit(settingsRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePageRout:
        return MaterialPageRoute(
          builder: (_) => kIsWeb ? const HomePageWeb() : const HomePage(),
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
      case popularPageRout:
        return MaterialPageRoute(
            builder: (_) => kIsWeb ? const PopularWeb() : const Popular());
      case safetySettingsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => safetySettingsCubit,
                  child: const SafetySettingsWeb(),
                ));
      case profileSettingsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => settingsCubit,
                  child: kIsWeb
                      ? const ProfileSettingsWeb()
                      : const ProfileSettings(),
                ));

      default:
        return null;
    }
  }
}
