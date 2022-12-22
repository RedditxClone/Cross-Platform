import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class SubredditWebServices {
  late Dio dio;
  SubredditWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
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

  Future<dynamic> getSubredditInfo(String subredditId) async {
    if (kIsWeb) {
      try {
        debugPrint(subredditId);
        Response response = await dio.get("subreddit/$subredditId",
            options: Options(
              headers: {"Authorization": "Bearer ${UserData.user!.token}"},
            ));
        debugPrint(response.data.toString());
        return response.data;
      } catch (e) {
        debugPrint(e.toString());
        return {'error': true};
      }
    } else {
      try {
        print(subredditId);
        Response response = await dio.get("subreddit/$subredditId",
            options: Options(
              headers: {"Authorization": "Bearer ${UserData.user!.token}"},
            ));
        return response.data;
      } on DioError catch (e) {
        debugPrint(e.response!.statusCode.toString());
        return {};
      }
    }
  }

  // Future<dynamic> getSubredditIcon(String subredditId) async {
  //   try {
  //     Response response = await dio.get("subreddit/r/$subredditId/icon",
  //         options: Options(
  //           headers: {"Authorization": "Bearer ${UserData.user!.token}"},
  //         ));

  //     return response.data;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  Future<dynamic> updateSubredditIcon(
      String subredditId, Uint8List updatedIcon) async {
    try {
      FormData formData = FormData.fromMap({
        "photo": MultipartFile.fromBytes(updatedIcon,
            contentType: MediaType('application', 'json'), filename: 'photo')
      });
      Response response = await dio.post('subreddit/r/$subredditId/icon',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint("update picture status code " +
          response.statusCode.toString() +
          " new image link : " +
          response.data);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  // getSubredditDescription(subredditId) async {
  //   try {
  //     Response response = await dio.get("subreddit/r/$subredditId/description",
  //         options: Options(
  //           headers: {"Authorization": "Bearer ${UserData.user!.token}"},
  //         ));

  //     return response.data;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  Future<dynamic> getSubredditModerators(String subredditId) async {
    try {
      Response response = await dio.get("subreddit/r/$subredditId/moderators",
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));

      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future<bool> joinSubreddit(String subredditId) async {
    try {
      Response response = await dio.post('subreddit/$subredditId/join',
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

  Future<bool> leaveSubreddit(String subredditId) async {
    try {
      Response response = await dio.post('subreddit/$subredditId/leave',
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

  Future<bool> getIfMod(String subredditId) async {
    if (kIsWeb) {
      try {
        Response response =
            await dio.get('subreddit/$subredditId/moderation/me',
                options: Options(
                  headers: {"Authorization": "Bearer ${UserData.user!.token}"},
                ));

        return response.data == 'true' ? true : false;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    } else {
      try {
        Response response =
            await dio.get('subreddit/$subredditId/moderation/me',
                options: Options(
                  headers: {"Authorization": "Bearer ${UserData.user!.token}"},
                ));

        return response.data == 'true' ? true : false;
      } on DioError catch (e) {
        debugPrint(e.response?.statusCode.toString());
        return false;
      }
    }
  }

  Future<bool> getIfJoined(String subredditId) async {
    if (kIsWeb) {
      try {
        Response response = await dio.get('subreddit/$subredditId/join/me',
            options: Options(
              headers: {"Authorization": "Bearer ${UserData.user!.token}"},
            ));
        print(response.statusCode);
        return response.data == 'true' ? true : false;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    } else {
      try {
        Response response = await dio.get('subreddit/$subredditId/join/me',
            options: Options(
              headers: {"Authorization": "Bearer ${UserData.user!.token}"},
            ));
        print(response.statusCode);
        return response.data == 'true' ? true : false;
      } on DioError catch (e) {
        debugPrint(e.response?.statusCode.toString());
        return false;
      }
    }
  }
}
