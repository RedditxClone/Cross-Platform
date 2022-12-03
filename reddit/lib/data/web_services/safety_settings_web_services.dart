import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';

/// This class is responsible of performing safety settings requests to the REST API
class SafetySettingsWebServices {
  late Dio dio;
  bool isMockerServer = useMockServerForAllWebServices;
  String token = '';
  SafetySettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: isMockerServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  /// Returns all user safety settings if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/me/prefs` to get all user settings from the API.
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

  /// [changed] : a [Map] that contains only the changed safety settings
  ///
  /// /// Returns status code 200 if success and 401 if there is an error occured (e.g. Unautherized) and 500 if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs patch request to the endpoint `baseUrl/user/me/prefs` to update some user's safety settings.
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
      return 500;
    }
  }

  /// [username] : the username we want to check his/her existance.
  ///
  /// Returns status code 200 if success  and 401 if there is an error occured (e.g. Unautherized) and null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs post request to the endpoint `baseUrl/user/check-available-username` to check the existance of a username.
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

  /// [username] : the username we want to block.
  ///
  /// Returns status code 200 if success  and 401 if there is an error occured (e.g. Unautherized) and `[]` (empty list) if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs post request to the endpoint `baseUrl/user/`[username]`/block` to block a user.
  Future<dynamic> blockUser(String username) async {
    // TODO : by user id not by username
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

  /// [username] : the username we want to unblock.
  ///
  /// Returns status code 200 if success  and 401 if there is an error occured (e.g. Unautherized) and `[]` (empty list) if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs post request to the endpoint `baseUrl/user/`[username]`/unblock` to unblock a user.
  Future<dynamic> unBlockUser(String username) async {
    // TODO : by user id not by username
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

  /// Returns [List] of the blocked users and `[]` (empty list) if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/block` to a user.
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
