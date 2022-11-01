import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';

class EmailSettingsWebServices {
  bool useMockServer = true;
  String mockUrl = TargetPlatform.android == defaultTargetPlatform
      ? "http://10.0.2.2:3001/"
      : "http://127.0.0.1:3001/";
  late Dio dio;
  EmailSettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getEmailSettings() async {
    try {
      Response response = await dio.get('user/me/prefs');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateEmailSettings(
      Map<String, dynamic> newAccSettings) async {
    try {
      Response response = await dio.patch(
        'user/me/prefs',
        data: newAccSettings,
      );
      if (response.statusCode == 200) {
        print("Email settings updated successfully");
      } else {
        print("Failed to updateEmail settings");
      }
    } catch (e) {
      print(e);
    }
  }
}
