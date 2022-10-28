import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:reddit/presentation/screens/Web/account_settings_screen_web.dart';
import 'package:reddit/presentation/screens/account_settings_screen.dart';
import 'package:reddit/presentation/screens/change_password_screen.dart';
import 'package:reddit/presentation/screens/country_screen.dart';
import 'package:reddit/presentation/screens/manage_blocked_accounts_screen.dart';
import 'package:reddit/presentation/screens/manage_notifications_screen.dart';
import 'package:reddit/presentation/screens/update_email_address_screen.dart';

class AppRouter {
  // platform
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
  // declare repository and cubit objects
  late AccountSettingsRepository accountSettingsRepository;
  late AccountSettingsCubit accountSettingsCubit;
  AppRouter() {
    // initialise repository and cubit objects
    accountSettingsRepository =
        AccountSettingsRepository(AccountSettingsWebServices());
    accountSettingsCubit = AccountSettingsCubit(accountSettingsRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
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
      case accountSettingsRoute:
        return MaterialPageRoute(
          builder: (_) => isMobile
              ? BlocProvider(
                  create: (context) => accountSettingsCubit,
                  child: const AccountSettingsScreen(),
                )
              : BlocProvider(
                  create: (context) => accountSettingsCubit,
                  child: const AccountSettingsScreenWeb(),
                ),
        );
      case updateEmailAddressRoute:
        return MaterialPageRoute(
            builder: (_) => UpdateEmailAddressScreen(arguments));
      case changePasswordRoute:
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen(arguments));
      case manageNotificationsRoute:
        return MaterialPageRoute(builder: (_) => ManageNotificationsScreen());
      case countryRoute:
        return MaterialPageRoute(builder: (_) => CountryScreen(arguments));
      case manageBlockedAccountsRoute:
        return MaterialPageRoute(
            builder: (_) => const ManageBlockedAccountsScreen());
      default:
        return null;
    }
  }
}
