import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'app_router.dart';
import 'data/model/auth_model.dart';
import 'helper/dio.dart';
import 'helper/utils/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await PreferenceUtils.init();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

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
      // initialRoute: homePageRoute,

      initialRoute: kIsWeb
          ? (UserData.isLogged() ? homePageRoute : popularPageRoute)
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
