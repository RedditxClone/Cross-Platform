import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class LeftDrawerWebServices {
  late Dio dio;
  LeftDrawerWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// `Returns` the communities that the user is currently moderating.
  /// This function performs `GET` request to the endpoint `baseUrl/subreddit/moderation/me`.
  Future<dynamic> getModeratingCommunities() async {
    try {
      Response response = await dio.get('subreddit/moderation/me',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint("${response.data}");
      debugPrint(
          "Get moderating communities, Status code is ${response.statusCode!}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        debugPrint(
            "Error in get moderating communities, Status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// `Returns` the communities that the user is currently joined in.
  /// This function performs `GET` request to the endpoint `baseUrl/subreddit/join/me`.
  Future<dynamic> getYourCommunities() async {
    try {
      Response response = await dio.get('/subreddit/join/me',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("${response.data}");
      debugPrint(
          "Get joined communities, Status code is ${response.statusCode!}");

      return response.data;
    } catch (e) {
      if (e is DioError) {
        debugPrint(
            "Error in Get communities, Status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// `Returns` the users that the user is currently following
  /// This function performs `GET` request to the endpoint `baseUrl/user/me/following`.
  Future<dynamic> getFollowingUsers() async {
    try {
      Response response = await dio.get('user/me/following',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("${response.data}");
      debugPrint("Get following, Status code ${response.statusCode!}");
      return response.data;
    } catch (e) {
      debugPrint("$e");
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in get following, Status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return {};
    }
  }
}
