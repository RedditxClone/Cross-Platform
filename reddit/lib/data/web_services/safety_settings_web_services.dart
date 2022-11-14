import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';

// This class is responsible of making request to the server
class SafetySettingsWebServices {
  late Dio dio;
  bool isMockerServer = false;
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNzI0ZjQ3NTg0NmUxM2VmZjg4MDkxOSIsImlhdCI6MTY2ODQ0Njk1MSwiZXhwIjoxNjY5MzEwOTUxfQ.GuYEH3ZpIrMQxdzhYGIJGxCDTCyyesPaidIPOYNRQOA';
  SafetySettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl:
          isMockerServer ? mockUrl : 'https://swproject.demosfortest.com/api/',
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
      debugPrint('status code : ${response.statusCode}');
      return response.data;
    } catch (e) {
      return null;
    }
  }

  /// patch request to update cover and profile photo
  Future<String> updateImage(String key, value) async {
    try {
      Response response = await dio.patch('user/me/profile',
          data: {key: value},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      return response.data;
    } catch (e) {
      return '';
    }
  }

  /// patch request to updates any user settings
  Future<int> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('user/me/prefs',
          data: changed,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      return response.statusCode!;
    } catch (e) {
      return 400;
    }
  }

  /// get request to check if the username available. used in safety settings to block someone
  Future<dynamic> checkUsernameAvailable(String username) async {
    try {
      Response response = await dio.post('user/check-available-username',
          queryParameters: {'username': username},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      return null;
    }
  }

  /// get request to get user's blocked list
  Future<dynamic> blockUser(String username) async {
    try {
      Response response = await dio.post('user/1/block',
          data: {'username': username},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      return [];
    }
  }

  /// get request to get user's blocked list
  Future<dynamic> unBlockUser(String username) async {
    try {
      Response response = await dio.post('user/1/unblock',
          data: {'username': username},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      return [];
    }
  }

  /// get request to get user's blocked list
  Future<dynamic> getBlockedUsers() async {
    try {
      Response response = await dio.get('user/block',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      return {"blocked": []}; // TODO : return response.data when
    } catch (e) {
      return [];
    }
  }
}
