import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';

class EmailSettingsWebServices {
  late Dio dio;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODhhNjFiNWUwYjU4M2Y0YTc5ZTQxYSIsImlhdCI6MTY2OTg5OTgwMywiZXhwIjoxNjcwNzYzODAzfQ.19uD_QlcThGaS_lZ0iE92q0771WwJSB2jgWfJPTWkn8";

  EmailSettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getEmailSettings() async {
    try {
      Response response = await dio.get('user/me/prefs',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<void> updateEmailSettings(
      Map<String, dynamic> newEmailSettings) async {
    try {
      Response response = await dio.patch('user/me/prefs',
          data: newEmailSettings,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      if (response.statusCode == 200) {
        debugPrint("updated Email settings");
      } else {
        debugPrint("Failed to update Email settings");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
