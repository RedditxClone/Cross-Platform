import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

/// This class is responsible of performing profile settings requests to the REST API
class SettingsWebServices {
  late Dio dio;
  bool isMockerServer = useMockServerForAllWebServices;

  SettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: isMockerServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  /// Returns all user profile settings if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/me/prefs` to get all user settings from the API.
  Future<dynamic> getUserSettings() async {
    try {
      Response response = await dio.get('user/me/prefs',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      return null;
    }
  }

  /// [key] : [String] that defines the type of photo we want to change 'coverPhoto' or 'profilePhoto'
  /// [file] : The new photo as a [File].
  ///
  /// Returns the path of the updated image if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs patch request to the endpoint `baseUrl/user/me/`[key] to update an image and get the
  /// from the new path the API.
  Future<dynamic> updateImage(File file, String key) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });
      Response response = await dio.patch('user/me/$key',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      // print(e.toString());
      return '';
    }
  }

  /// [key] : [String] that defines the type of photo we want to change 'coverPhoto' or 'profilePhoto'
  /// [fileAsBytes] : The new photo as a [Uint8List] type.
  ///
  /// Returns the path of the updated image if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs patch request to the endpoint `baseUrl/user/me/`[key] to update an image and get the
  /// from the new path the API.
  Future<dynamic> updateImageWeb(Uint8List fileAsBytes, String key) async {
    try {
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(fileAsBytes,
            contentType: MediaType('application', 'json'), filename: key)
      });
      Response response = await dio.patch('user/me/$key',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(response.statusCode.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  /// [changed] : a [Map] that contains only the changed profile settings
  ///
  /// /// Returns status code 200 if request is success and or 401 if an error occured or null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs patch request to the endpoint `baseUrl/user/me/prefs` to update some user's profile settings.
  Future<dynamic> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('user/me/prefs',
          data: changed,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(response.statusCode.toString());
      return response.statusCode;
    } catch (e) {
      return null;
    }
  }
}
