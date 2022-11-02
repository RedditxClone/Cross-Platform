import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/user_settings.dart';

class SettingsWebServices {
  late Dio dio;
  // String mockUrl = TargetPlatform.android == defaultTargetPlatform
  //     ? "http://10.0.2.2:3000/"
  //     : "http://127.0.0.1:3000/";
  String mockUrl =
      'https://4e3b1a52-b358-471e-a853-ddbca4d767d5.mock.pstmn.io/';
  bool isMockerServer = true;
  SettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: isMockerServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  /// Returns all user settings : Performs get request to the endpoint /prefs to get all user settings from the API
  Future<dynamic> getUserSettings() async {
    try {
      Response response = await dio.get('prefs');
      return response.data;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  /// updates a image
  Future<String> updateImage(String key, value) async {
    try {
      Response response = await dio.patch('prefs', data: {key: value});
      return response.data;
    } catch (e) {
      // print(e.toString());
      return '';
    }
  }

  /// updates a user setting
  Future<String> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('prefs', data: changed);
      return response.data;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}
