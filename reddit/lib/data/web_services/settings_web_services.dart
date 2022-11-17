import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';

class SettingsWebServices {
  late Dio dio;
  bool isMockerServer = useMockServerForAllWebServices;
  String token = '';
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
      Response response = await dio.get('user/me/prefs',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      return null;
    }
  }

  /// updates a image
  Future<dynamic> updateImage(File file, String key) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });
      Response response = await dio.patch('user/me/$key',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      // print(e.toString());
      return '';
    }
  }

  /// updates a image
  Future<dynamic> updateImageWeb(Uint8List fileAsBytes, String key) async {
    try {
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(fileAsBytes,
            contentType: MediaType('application', 'json'), filename: key)
      });
      Response response = await dio.patch('user/me/$key',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  /// updates a user setting
  Future<dynamic> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('user/me/prefs',
          data: changed,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
