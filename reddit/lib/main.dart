import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'app_router.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
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
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: kIsWeb
          ? (isLoggedIn ? homePageRoute : popularPageRoute)
          : homePageRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          appRouter.generateRoute(RouteSettings(
              name: kIsWeb
                  ? (isLoggedIn ? homePageRoute : popularPageRoute)
                  : homePageRoute,
              arguments: {"isLoggedIn": isLoggedIn}))!,
        ];
      },
    );
  }
}
