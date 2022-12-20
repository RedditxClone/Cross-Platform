import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:workmanager/workmanager.dart';
import 'app_router.dart';
import 'data/model/auth_model.dart';
import 'helper/dio.dart';
import 'helper/utils/shared_pref.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    try {
      // initialise the plugin of flutterlocalnotifications.
      FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

      // app_icon needs to be a added as a drawable
      // resource to the Android head project.
      AndroidInitializationSettings android =
          const AndroidInitializationSettings('@mipmap/ic_launcher');

      // initialise settings for both Android and iOS device.
      InitializationSettings settings =
          InitializationSettings(android: android);
      flip.initialize(settings);
      _showNotificationWithDefaultSound(flip);
      print(
          "Native called background task: "); //simpleTask will be emitted here.

    } catch (e) {
      debugPrint(
          "$e"); // Logger flutter package, prints error on the debug console

    }
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  AndroidNotificationDetails androidPlatformChannelDetails =
      const AndroidNotificationDetails('your channel id', 'your channel name',
          // 'your channel description',
          importance: Importance.max,
          priority: Priority.max);

  // initialise channel platform for both Android and iOS device.
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelDetails);
  await flip.show(
      0,
      'Redditx',
      '1 new notification',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await PreferenceUtils.init();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
    // frequency: Duration(hours: 1),
  );
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
      // initialRoute: searchRouteWeb,
      // initialRoute: tafficRoute,

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
