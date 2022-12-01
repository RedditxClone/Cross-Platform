import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';

class SubredditWebServices {
  late Dio dio;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODhhNjFiNWUwYjU4M2Y0YTc5ZTQxYSIsImlhdCI6MTY2OTg5OTgwMywiZXhwIjoxNjcwNzYzODAzfQ.19uD_QlcThGaS_lZ0iE92q0771WwJSB2jgWfJPTWkn8";
  SubredditWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://swproject.demosfortest.com/api/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getPostsInPage(String subreddit, String mode) async {
    try {
      Response response = await dio.get("subreddit/$subreddit/$mode",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return "[]";
    }
  }

  Future<dynamic> getSubredditInfo(String subredditName) async {
    try {
      Response response = await dio.get("subreddit/r/$subredditName",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return "{}";
    }
  }

  Future<dynamic> getSubredditIcon(String subreddit) async {
    try {
      Response response = await dio.get("subreddit/r/$subreddit/icon",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future<bool> updateSubredditIcon(
      String subredditName, Uint8List updatedIcon) async {
    final fields = {
      'file': MultipartFile.fromBytes(updatedIcon,
          contentType: MediaType('application', 'json'), filename: "icon.jpg")
    };
    final formData = FormData.fromMap(fields);
    debugPrint(formData.fields.toString());
    try {
      Response response = await dio.post('subreddit/r/$subredditName/icon',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint(response.statusCode.toString());
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  getSubredditDescription(subreddit) async {
    try {
      Response response = await dio.get("subreddit/r/$subreddit/description",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getSubredditModerators(String subreddit) async {
    try {
      Response response = await dio.get("subreddit/r/$subreddit/moderators",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return "";
    }
  }
}
