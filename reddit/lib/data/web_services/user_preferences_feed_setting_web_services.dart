// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

/// Web Services for Updating User Preferences (feed settings) sending to "/api/user/me/prefs".
class UserPreferencesFeedSettingWebServices {
  ///Mock Server for Testing
  bool useMockServer = true;
  // Mock URL For Mockoon
  // String mockUrl = TargetPlatform.android == defaultTargetPlatform
  //     ? "http://10.0.2.2:3001/"
  //     : "http://127.0.0.1:3001/";
  // Mock URL For Postman
  String mockUrl =
      "https://a8eda59d-d8f3-4ef2-9581-29e6473824d9.mock.pstmn.io/";

  late Dio dio;

  ///Setting Dio Options.
  UserPreferencesFeedSettingWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  ///Getting Response of 'https://swproject.demosfortest.com/api#/User/UserController_updateUserPrefs'
  Future<int> updateFeedSetting(
      Map<String, dynamic> updateFeedSettingMap) async {
    try {
      Response response = await dio.patch(
        'user/me/prefs',
        data: updateFeedSettingMap,
      );
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Account settings updated successfully");
      } else {
        print("Failed to updateAccount settings");
      }
      return response.statusCode!;
    } catch (e) {
      print(e);
      return 404;
    }
  }
}
