import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class SubredditWebServices {
  late Dio dio;
 SubredditWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl:
          "https://f1c179b0-0158-4a47-ba39-7b803b8ae58a.mock.pstmn.io/api/",
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
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));

      return response.data;
    } catch (e) {
      return "[]";
    }
  }

  Future<dynamic> getSubredditInfo(String subredditName) async {
    try {
      Response response = await dio.get("subreddit/r/",
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
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
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
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
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
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
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
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
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));

      return response.data;
    } catch (e) {
      return "";
    }
  }
}
