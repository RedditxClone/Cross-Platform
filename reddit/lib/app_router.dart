import 'package:flutter/material.dart';
import 'package:reddit/data/repository/feed_setting_repository.dart';
import 'package:reddit/data/web_services/feed_setting_web_services.dart';
import 'business_logic/cubit/feed_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FeedSettingsCubit(FeedSettingRepository(
                feedSettingsWebServices: FeedSettingWebServices())),
            child: const FeedSetting(),
          ),
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
