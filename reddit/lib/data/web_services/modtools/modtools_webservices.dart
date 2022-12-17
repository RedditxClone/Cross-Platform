import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

/// This class is responsible of performing safety settings requests to the REST API
class ModToolsWebServices {
  late Dio dio;
  bool isMockerServer = useMockServerForAllWebServices;

  ModToolsWebServices() {
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
  Future<dynamic> getApproved(String subredditID) async {
    try {
      Response response = await dio.get('subreddit/$subredditID/user/approve',
          options: Options(
            headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
          ));
      debugPrint('getApproved status code : ${response.statusCode}');
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// Returns all user safety settings if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/me/prefs` to get all user settings from the API.
  Future<dynamic> addApprovedUser(String subredditID, String username) async {
    try {
      Response response = await dio.post('subreddit/$subredditID/user/approve',
          data: {"username": username},
          options: Options(
            headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
          ));
      debugPrint(
          'AppApprovedUser $username status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// Returns all user safety settings if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/me/prefs` to get all user settings from the API.
  Future<dynamic> removeApprovedUser(String subredditID, String userID) async {
    try {
      Response response =
          await dio.delete('subreddit/$subredditID/user/$userID/approve',
              options: Options(
                headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
              ));
      debugPrint(
          'RemoveApprovedUser $userID status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
