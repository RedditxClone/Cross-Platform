import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:reddit/presentation/screens/signup_page.dart';
import 'app_router.dart';
import 'helper/dio.dart';
import 'helper/utils/shared_pref.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
  DioHelper.init();
  PreferenceUtils.init();
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  MyApp({Key? key, required this.appRouter}) : super(key: key);

  bool isLoggedIn = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        primaryColorDark: Colors.black,
        primaryColor: Colors.black,
        dialogBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      // initialRoute: modlistRoute,

      initialRoute: kIsWeb
          ? (isLoggedIn ? homePageRoute : popularPageRoute)
          : homePageRoute,

      // onGenerateInitialRoutes: (String initialRouteName) {
      //   return [
      //     appRouter.generateRoute(RouteSettings(
      //         name: kIsWeb
      //             ? (isLoggedIn ? homePageRoute : popularPageRoute)
      //             : homePageRoute,
      //         arguments: {"isLoggedIn": isLoggedIn}))!,
      //   ];
      // },
    );
  }
}
