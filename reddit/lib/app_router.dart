import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/business_logic/cubit/choose_profile_image_login_cubit.dart';
import 'package:reddit/presentation/screens/profile/others_profile_page_web.dart';
import 'package:reddit/presentation/screens/profile/profile_page_web.dart';
import 'package:reddit/presentation/screens/profile/profile_screen.dart';
import 'presentation/screens/setting_tab_ui.dart';
import 'package:reddit/presentation/screens/recaptcha_screen.dart'
    if (dart.library.html) 'package:reddit/presentation/screens/recaptcha_screen_web.dart'
    as recaptcha_screen;
import 'package:reddit/business_logic/cubit/history_page_cubit.dart';

import 'package:reddit/data/repository/history_page_repository.dart';

import 'package:reddit/data/web_services/history_page_web_services.dart';

import 'package:reddit/presentation/screens/history_screen.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';
import 'package:reddit/presentation/screens/home/home_page_mobile.dart';
import 'package:reddit/presentation/screens/home/home_page_web.dart';
import 'package:reddit/presentation/screens/popular/popular.dart';
import 'package:reddit/presentation/screens/popular/popular_web.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/screens/profile_settings_screen.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen_web.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen.dart';
import 'package:reddit/presentation/screens/account_settings/change_password_screen.dart';
import 'package:reddit/presentation/screens/account_settings/country_screen.dart';
import 'package:reddit/presentation/screens/account_settings/manage_blocked_accounts_screen.dart';
import 'package:reddit/presentation/screens/account_settings/manage_notifications_screen.dart';
import 'package:reddit/presentation/screens/account_settings/update_email_address_screen.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/choose_gender_android.dart';
import 'package:reddit/presentation/screens/choose_profile_screen.dart';
import 'package:reddit/presentation/screens/forget_password_android.dart';
import 'package:reddit/presentation/screens/forget_password_web.dart';
import 'package:reddit/presentation/screens/forget_username_android.dart';
import 'package:reddit/presentation/screens/forget_username_web.dart';
import 'package:reddit/presentation/screens/intesrests_android.dart';
import 'package:reddit/presentation/screens/login_page.dart';
import 'package:reddit/presentation/screens/login_screen.dart';
import 'package:reddit/presentation/screens/signup_page.dart';
import 'package:reddit/presentation/screens/signup_page2.dart';
import 'package:reddit/presentation/screens/signup_screen.dart';

import 'data/model/signin.dart';

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
  late ChooseProfileImageLoginCubit chooseProfileImageLoginCubit;

  late EmailSettingsRepository emailSettingsReposity;
  late EmailSettingsCubit emailSettingsCubit;
  late EmailSettingsWebServices emailSettingsWebServices;

  late HistoryPageCubit historyPageCubit;
  late HistoryPageRepository historyPageRepository;
  late HistoryPageWebServices historyPageWebServices;

  static User? user;
  AppRouter() {
    // initialise repository and cubit objects
    safetySettingsRepository =
        SafetySettingsRepository(SafetySettingsWebServices());
    safetySettingsCubit = SafetySettingsCubit(safetySettingsRepository);
    settingsRepository = SettingsRepository(SettingsWebServices());
    settingsCubit = SettingsCubit(settingsRepository);
    chooseProfileImageLoginCubit =
        ChooseProfileImageLoginCubit(settingsRepository);
    emailSettingsWebServices = EmailSettingsWebServices();
    emailSettingsReposity = EmailSettingsRepository(emailSettingsWebServices);
    emailSettingsCubit = EmailSettingsCubit(emailSettingsReposity);

    accountSettingsRepository =
        AccountSettingsRepository(AccountSettingsWebServices());
    accountSettingsCubit = AccountSettingsCubit(accountSettingsRepository);

    historyPageWebServices = HistoryPageWebServices();
    historyPageRepository = HistoryPageRepository(historyPageWebServices);
    historyPageCubit = HistoryPageCubit(historyPageRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case homePageRoute:
        user = settings.arguments as User?;
        return MaterialPageRoute(
          builder: (_) => kIsWeb ? HomePageWeb(user) : HomePage(user),
        );

      case popularPageRoute:
        final user = settings.arguments as User?;
        return MaterialPageRoute(
            builder: (_) => kIsWeb ? PopularWeb(user) : const Popular());

      case profilePageRoute:
        return MaterialPageRoute(
            builder: (_) =>
                kIsWeb ? const ProfilePageWeb() : const ProfileScreen());

      case otherProfilePageRoute:
        return MaterialPageRoute(
            builder: (_) =>
                kIsWeb ? const OtherProfilePageWeb() : const ProfileScreen());

      case historyPageScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: historyPageCubit,
                  child: HistoryPageScreen(
                    userID: "Disastrous_Welcome96",
                  ),
                ));

      // case emailSettingsWebScreenRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value: emailSettingsCubit,
      //             child: const EmailSettingsWeb(),
      //           ));
      // case HOME_PAGE:
      //   final user = settings.arguments as User;
      //   return MaterialPageRoute(
      //     builder: (_) => Home(user: user),
      //   );

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
      case interesetesScreen:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => InteresetesAndroid(
            newUser: user,
          ),
        );
      case chooseProfileImgScreen:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => chooseProfileImageLoginCubit,
            child: ChooseProfileImgAndroid(
              newUser: user,
            ),
          ),
        );
      case chooseGenderScreen:
        final user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => ChooseGenderAndroid(
            newUser: user,
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

      case recaptchaRoute:
        // return MaterialPageRoute(builder: (_) => const RecaptchaScreenWeb());
        return MaterialPageRoute(
            builder: (_) => const recaptcha_screen.RecaptchaScreen());

      case accountSettingsRoute:
        return MaterialPageRoute(
          builder: (_) => isMobile
              ? BlocProvider(
                  create: (context) => accountSettingsCubit,
                  child: AccountSettingsScreen(arguments),
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
        return MaterialPageRoute(builder: (_) => SettingTabUi(user: user));

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
