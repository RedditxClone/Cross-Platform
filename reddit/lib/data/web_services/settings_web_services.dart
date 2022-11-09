import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

class SettingsWebServices {
  late Dio dio;
  // String mockUrl = TargetPlatform.android == defaultTargetPlatform
  //     ? "http://10.0.2.2:3000/"
  //     : "http://127.0.0.1:3000/";
  String mockUrl =
      'https://a8eda59d-d8f3-4ef2-9581-29e6473824d9.mock.pstmn.io/';
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
      return '';
    }
  }

  /// updates a image
  Future<String> updateImage(File file, String key) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });
      Response response = await dio.patch(key, data: formData);
      return response.data;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  /// updates a user setting
  Future<String> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('prefs', data: changed);
      return response.data;
    } catch (e) {
      return '';
    }
  }
}
