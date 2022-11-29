import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';

class SubredditWebServices {
  bool useMockServer = true;
  String mockUrl = "https://f1c179b0-0158-4a47-ba39-7b803b8ae58a.mock.pstmn.io";
  late Dio dio;
  SubredditWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getPostsInPage(String subreddit, String mode) async {
    try {
      Response response = await dio.get("/api/subreddit/$subreddit/$mode");
      return response.data;
    } catch (e) {
      return "[]";
    }
  }

  Future<dynamic> getSubredditInfo(String subredditName) async {
    try {
      Response response = await dio.get("/api/subreddit/$subredditName/about");
      return response.data;
    } catch (e) {
      return "{}";
    }
  }

  Future<dynamic> getSubredditIcon(String subreddit) async {
    try {
      Response response = await dio.get("/api/subreddit/$subreddit/icon");
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
      Response response =
          await dio.post('/api/subreddit/$subredditName/icon', data: formData);
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
      Response response = await dio.get("/api/subreddit/$subreddit/description");
      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getSubredditModerators(String subreddit) async {
    try {
      Response response = await dio.get("subreddit/$subreddit/moderators");
      return response.data;
    } catch (e) {
      return "";
    }
  }
}
