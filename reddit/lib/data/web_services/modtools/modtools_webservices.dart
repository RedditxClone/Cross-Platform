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

  /// [subredditID] is the id of subreddit to which we get the approved list
  /// Returns approved users in modtools as [List] of `Map<String,dynamic>`
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

  /// [subredditID] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// Returns status code 201 if insert is successfull
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

  /// [subredditID] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// Returns status code 201 if remove is successfull
  Future<dynamic> removeApprovedUser(
      String subredditID, String username) async {
    try {
      Response response =
          await dio.delete('subreddit/$subredditID/user/$username/approve',
              options: Options(
                headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
              ));
      debugPrint(
          'RemoveApprovedUser $username status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
