import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/setting_tab_ui.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/recaptcha_screen.dart'
    if (dart.library.html) 'package:reddit/presentation/screens/recaptcha_screen_web.dart'
    as recaptcha_screen;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
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
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'constants/strings.dart';
import 'presentation/screens/email_settings_web.dart';

import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen_web.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen.dart';
import 'package:reddit/presentation/screens/account_settings/change_password_screen.dart';
import 'package:reddit/presentation/screens/account_settings/country_screen.dart';
import 'package:reddit/presentation/screens/account_settings/manage_blocked_accounts_screen.dart';
import 'package:reddit/presentation/screens/account_settings/manage_notifications_screen.dart';
import 'package:reddit/presentation/screens/account_settings/update_email_address_screen.dart';

class AppRouter {
  // platform
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
  // declare repository and cubit objects

  late AccountSettingsRepository accountSettingsRepository;
  late AccountSettingsCubit accountSettingsCubit;

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

    accountSettingsRepository =
        AccountSettingsRepository(AccountSettingsWebServices());
    accountSettingsCubit = AccountSettingsCubit(accountSettingsRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case homePageRoute:
        Map<String, dynamic> argMap = arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => kIsWeb
              ? HomePageWeb(isLoggedIn: argMap["isLoggedIn"])
              : HomePage(argMap["isLoggedIn"]),
        );

      // case emailSettingsWebScreenRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value: emailSettingsCubit,
      //             child: const EmailSettingsWeb(),
      //           ));
      case settingTabUiRoute:
        return MaterialPageRoute(builder: (_) => const SettingTabUi());

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
      case popularPageRoute:
        Map<String, dynamic> argMap = arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => kIsWeb
                ? PopularWeb(isLoggedIn: argMap["isLoggedIn"])
                : const Popular());

      case recaptchaRoute:
        // return MaterialPageRoute(builder: (_) => const RecaptchaScreenWeb());
        return MaterialPageRoute(
            builder: (_) => const recaptcha_screen.RecaptchaScreen());

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
      case settingsTabsRoute:
        return MaterialPageRoute(builder: (_) => const SettingTabUi());

      case changePasswordRoute:
        return MaterialPageRoute(builder: (context) {
          Map<String, dynamic> argMap = arguments as Map<String, dynamic>;
          return BlocProvider.value(
            value: BlocProvider.of<AccountSettingsCubit>(
                argMap["context"] as BuildContext),
            child: ChangePasswordScreen(arguments),
          );
        });
      case manageNotificationsRoute:
        return MaterialPageRoute(
            builder: (_) => const ManageNotificationsScreen());
      case countryRoute:
        return MaterialPageRoute(builder: (_) => CountryScreen(arguments));
      case manageBlockedAccountsRoute:
        return MaterialPageRoute(
            builder: (_) => const ManageBlockedAccountsScreen());

      // case safetySettingsRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (BuildContext context) => safetySettingsCubit,
      //             child: const SafetySettingsWeb(),
      //           ));
      case profileSettingsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => settingsCubit,
                  child: ProfileSettingsScreen(),
                ));

      default:
        return null;
    }
  }
}
