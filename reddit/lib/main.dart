import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      // ),
      // themeMode: ThemeMode.dark,
    );
  }
}
