import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

class CreateCommunityWebServices {
  late Dio dio;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODhhNjFiNWUwYjU4M2Y0YTc5ZTQxYSIsImlhdCI6MTY2OTg5OTgwMywiZXhwIjoxNjcwNzYzODAzfQ.19uD_QlcThGaS_lZ0iE92q0771WwJSB2jgWfJPTWkn8";
  CreateCommunityWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// Sends create community request to the server, the repository calls this function
  Future<bool> createCommunity(Map<String, dynamic> communityData) async {
    try {
      Response response = await dio.post('/api/subreddit',
          data: communityData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint(e.response?.statusMessage.toString());
      return false;
    }
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    try {
      Response response =
          await dio.get('/api/subreddit/r/$subredditName/available',
              options: Options(
                headers: {"Authorization": "Bearer $token"},
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
