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

  /// [subredditName] is the name of subreddit to get the edited posts
  /// `Returns` edited posts to the modtools of the subreddit.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getEditedPosts(String subredditName) async {
    try {
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = await dio.get('subreddit/$subredditName/edited',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(
          "subreddit edited posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in subreddit edited posts, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// [subredditName] is the name of subreddit to get the spammed posts
  /// `Returns` spammed posts to the modtools of the subreddit.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getSpammedPosts(String subredditName) async {
    try {
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = await dio.get('subreddit/$subredditName/spammed',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(
          "subreddit spammed posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in subreddit spammed posts, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// [subredditName] is the name of subreddit to get the statistics
  Future<List<dynamic>> getStatistics(String subredditName) async {
    try {
      Response response = await dio.get(
          'subreddit/$subredditName/statistics/week',
          options: UserData.isLoggedIn
              ? Options(
                  headers: {"Authorization": "Bearer ${UserData.user!.token}"},
                )
              : null);
      return response.data;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Status code is ${e.response!.data}");
      }
      debugPrint("$e");
      return [];
    }
  }

  /// [subredditName] is the name of subreddit to get the unmoderated posts
  /// `Returns` unmoderated posts to the modtools of the subreddit.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getUnmoderatedPosts(String subredditName) async {
    try {
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = await dio.get('subreddit/$subredditName/unmoderated',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(
          "subreddit unmoderated posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in subreddit unmoderated posts, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// [subredditId] is the id of subreddit to get the approved list
  /// Returns approved users in modtools as [List] of `Map<String,dynamic>`
  Future<dynamic> getApproved(String subredditId) async {
    try {
      Response response = await dio.get('subreddit/$subredditId/user/approve',
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

  /// [subredditId] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// Returns status code 201 if insert is successfull
  Future<dynamic> addApprovedUser(String subredditId, String username) async {
    try {
      Response response = await dio.post('subreddit/$subredditId/user/approve',
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

  /// [subredditId] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// Returns status code 201 if remove is successfull
  Future<dynamic> removeApprovedUser(
      String subredditId, String username) async {
    try {
      Response response =
          await dio.delete('subreddit/$subredditId/user/$username/approve',
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
