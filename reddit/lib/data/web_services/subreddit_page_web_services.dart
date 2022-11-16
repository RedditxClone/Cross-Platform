import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';

class SubredditWebServices {
  bool useMockServer = true;
  String mockUrl =
      "https://f1c179b0-0158-4a47-ba39-7b803b8ae58a.mock.pstmn.io/";
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
      Response response = await dio.get("subreddit/$subreddit/$mode");
      return response.data;
    } catch (e) {
      return "[]";
    }
  }

  Future<dynamic> getSubredditInfo(String subredditID) async {
    try {
      Response response = await dio.get("subreddit/$subredditID/about");
      return response.data;
    } catch (e) {
      return "{}";
    }
  }

  Future<dynamic> getSubredditIcon(String subreddit) async {
    try {
      Response response = await dio.get("subreddit/$subreddit/icon");
      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future<bool> updateSubredditIcon(
      String subredditID, Uint8List updatedIcon) async {
    final fields = {
      'file': MultipartFile.fromBytes(updatedIcon,
          contentType: MediaType('application', 'json'), filename: "icon.jpg")
    };
    final formData = FormData.fromMap(fields);
    print(formData.fields);
    try {
      Response response =
          await dio.post('subreddit/$subredditID/icon', data: formData);
      if (response.statusCode == 201) {
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  getSubredditDescription(subreddit) async {
    try {
      Response response = await dio.get("subreddit/$subreddit/description");
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
