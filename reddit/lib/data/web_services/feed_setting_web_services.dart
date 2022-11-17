// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
//import 'package:reddit/constants/strings.dart';

/// Web Services for Updating User Preferences (feed settings)
class FeedSettingWebServices {
  late Dio dio;

  ///Setting Dio Options.
  FeedSettingWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://89bbb438-a7b6-4a06-9fdd-45dcf61198d3.mock.pstmn.io/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<dynamic> getFeedSettings() async {
    try {
      Response response = await dio.get('user/me/prefs');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<int> updateFeedSetting(Map<String, dynamic> newFeedSettingMap) async {
    try {
      Response response = await dio.patch(
        'user/me/prefs',
        data: newFeedSettingMap,
      );
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Feed settings updated successfully");
      } else {
        print("Failed to update Feed settings");
      }
      return response.statusCode!;
    } catch (e) {
      print(e);
      return 404;
    }
  }
}
