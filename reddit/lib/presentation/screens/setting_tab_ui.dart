import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/business_logic/cubit/feed_settings_cubit.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/repository/feed_setting_repository.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'package:reddit/data/web_services/feed_setting_web_services.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen_web.dart';
import 'package:reddit/presentation/screens/email_settings_web.dart';
import 'package:reddit/presentation/screens/feed_setting.dart';
import 'package:reddit/presentation/screens/profile_settings_web.dart';
import 'package:reddit/presentation/screens/safety_settings_web.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class SettingTabUi extends StatefulWidget {
  // User? user;
  SettingTabUi({super.key});

  @override
  State<SettingTabUi> createState() => _SettingTabUiState();
}

class _SettingTabUiState extends State<SettingTabUi> {
  late Responsive responsive;
  late int index;
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title:
              AppBarWebLoggedIn(user: UserData.user!, screen: 'User settings')),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex: responsive.isSmallSizedScreen() ? 0 : 1,
                child: const SizedBox(width: 1)),
            Expanded(
              flex: 6,
              child: DefaultTabController(
                length: 5,
                animationDuration: Duration.zero,
                child: Container(
                  height: 1400,
                  color: Colors.transparent,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      title: const Text(
                        'User settings',
                        style: TextStyle(color: Colors.white),
                      ),
                      bottom: TabBar(
                        indicator: const UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white),
                            insets: EdgeInsets.symmetric(horizontal: 25)),
                        padding: EdgeInsets.only(
                            right: responsive.isXLargeSizedScreen()
                                ? 500
                                : responsive.isLargeSizedScreen()
                                    ? 300
                                    : responsive.isMediumSizedScreen()
                                        ? 100
                                        : 0),
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 131, 122, 122),
                        tabs: const <Widget>[
                          Tab(
                            child: Text("Account"),
                          ),
                          Tab(
                            child: Text("Profile"),
                          ),
                          Tab(
                            child: Text("Safety and privacy"),
                          ),
                          Tab(
                            child: Text("Feed Settings"),
                          ),
                          Tab(
                            child: Text("Email"),
                          ),
                        ],
                      ),
                    ),
                    body: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TabBarView(
                            children: <Widget>[
                              BlocProvider(
                                create: (context) => AccountSettingsCubit(
                                    AccountSettingsRepository(
                                        AccountSettingsWebServices())),
                                child: const AccountSettingsScreenWeb(),
                              ),
                              BlocProvider(
                                create: (BuildContext context) => SettingsCubit(
                                    SettingsRepository(SettingsWebServices())),
                                child: const ProfileSettingsWeb(),
                              ),
                              BlocProvider(
                                create: (BuildContext context) =>
                                    SafetySettingsCubit(
                                        SafetySettingsRepository(
                                            SafetySettingsWebServices())),
                                child: const SafetySettingsWeb(),
                              ),
                              BlocProvider(
                                create: (context) => FeedSettingsCubit(
                                    FeedSettingRepository(
                                        feedSettingsWebServices:
                                            FeedSettingWebServices())),
                                child: const FeedSetting(),
                              ),
                              BlocProvider.value(
                                value: EmailSettingsCubit(
                                    EmailSettingsRepository(
                                        EmailSettingsWebServices())),
                                child: const EmailSettingsWeb(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: responsive.isSmallSizedScreen()
                                ? 0
                                : responsive.isMediumSizedScreen()
                                    ? 1
                                    : responsive.isLargeSizedScreen()
                                        ? 2
                                        : 3,
                            child: const SizedBox(width: 1)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
