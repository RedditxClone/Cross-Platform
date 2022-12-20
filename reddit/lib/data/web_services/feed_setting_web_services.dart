import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/auth_model.dart';

/// Web Services for Updating User Preferences (feed settings)
///
///This class is responsible of performing feed settings requests to the REST API
class FeedSettingWebServices {
  late Dio dio;
  //String mockUrl = "https://89bbb438-a7b6-4a06-9fdd-45dcf61198d3.mock.pstmn.io/";
  ///Setting Dio Options.
  FeedSettingWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// Returns all feed settings if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/me/prefs` to get all user settings from the API.
  Future<dynamic> getFeedSettings() async {
    try {
      Response response = await dio.get('user/me/prefs',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint('status code : ${response.statusCode}');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// [newFeedSettingMap] : a [Map<String, dynamic>] that contains only the changed feed settings
  ///
  /// /// Returns status code 200 if request is success and or 401 if an error occured or null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs patch request to the endpoint `baseUrl/user/me/prefs` to update some user's feed settings.
  Future<int> updateFeedSetting(Map<String, dynamic> newFeedSettingMap) async {
    try {
      Response response = await dio.patch('user/me/prefs',
          data: newFeedSettingMap,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Feed settings updated successfully");
      } else {
        print("Failed to update Feed settings");
      }
      debugPrint('status code : ${response.statusCode}');
      return response.statusCode!;
    } catch (e) {
      print(e);
      return 404;
    }
  }
}
