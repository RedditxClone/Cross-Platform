// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';
import 'package:reddit/presentation/screens/safety_settings_web.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/screens/profile_settings_screen.dart';
import 'package:reddit/presentation/screens/profile_settings_web.dart';
import 'package:reddit/presentation/screens/discover_page.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'constants/strings.dart';
import 'presentation/screens/email_settings_web.dart';

class AppRouter {
  // declare repository and cubit objects
  late SafetySettingsRepository safetySettingsRepository;
  late SafetySettingsCubit safetySettingsCubit;
  late SettingsRepository settingsRepository;
  late SettingsCubit settingsCubit;

  late EmailSettingsRepository emailSettingsReposity;
  late EmailSettingsCubit emailSettingsCubit;
  late EmailSettingsWebServices emailSettingsWebServices;
  AppRouter() {
    // initialise repository and cubit objects
    safetySettingsRepository =
        SafetySettingsRepository(SafetySettingsWebServices());
    safetySettingsCubit = SafetySettingsCubit(safetySettingsRepository);
    settingsRepository = SettingsRepository(SettingsWebServices());
    settingsCubit = SettingsCubit(settingsRepository);
    emailSettingsWebServices = EmailSettingsWebServices();
    emailSettingsReposity = EmailSettingsRepository(emailSettingsWebServices);
    emailSettingsCubit = EmailSettingsCubit(emailSettingsReposity);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(),
                  body: Container(),
                ));

      case emailSettingsWebScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: emailSettingsCubit,
                  child: const EmailSettingsWeb(),
                ));
      case discoverPageRoute:
        return MaterialPageRoute(builder: (_) => const DiscoverPage());
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
