import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'constants/strings.dart';
import 'presentation/screens/email_settings_web.dart';
import 'presentation/screens/home_page.dart';

class AppRouter {
  // declare repository and cubit objects
  late EmailSettingsRepository emailSettingsReposity;
  late EmailSettingsCubit emailSettingsCubit;
  late EmailSettingsWebServices emailSettingsWebServices;

  AppRouter() {
    // initialise repository and cubit objects
    emailSettingsWebServices = EmailSettingsWebServices();
    emailSettingsReposity = EmailSettingsRepository(emailSettingsWebServices);
    emailSettingsCubit = EmailSettingsCubit(emailSettingsReposity);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case emailSettingsWebScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: emailSettingsCubit,
                  child: const EmailSettingsWeb(),
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
