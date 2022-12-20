import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

import '../model/auth_model.dart';

class CreateCommunityWebServices {
  late Dio dio;
  CreateCommunityWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  // /// Sends create community request to the server, the repository calls this function
  // Future<Response?> createCommunity(Map<String, dynamic> communityData) async {
  //   try {
  //     Response response = await dio.post('subreddit',
  //         data: communityData,
  //         options: Options(
  //           headers: {"Authorization": "Bearer ${UserData.user!.token}"},
  //         ));
  //     if (response.statusCode == 201) {
  //       debugPrint(response.data.toString());
  //     }

  //     return response;
  //   } on DioError catch (e) {
  //     debugPrint(e.response?.statusCode.toString());
  //     debugPrint(e.response?.statusMessage.toString());
  //     return e.response;
  //   }
  // }

  /// Save a post.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/save`.
  Future<Response?> createCommunity(Map<String, dynamic> communityData) async {
    try {
      Response response = await dio.post(
        'subreddit',
        options: Options(
          headers: {"Authorization": "Bearer ${UserData.user!.token}"},
        ),
        data: communityData,
      );
      debugPrint("Up vote in web services ${response.data}");
      debugPrint("Create community status code ${response.statusCode}");
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in create community, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
          return e.response;
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return null;
    }
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    try {
      Response response = await dio.get('subreddit/r/$subredditName/available',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));

      if (response.statusCode == 200) {
        debugPrint("available");
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
      return false;
    }
  }
}
