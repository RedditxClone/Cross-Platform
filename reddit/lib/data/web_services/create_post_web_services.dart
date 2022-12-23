import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';

import '../model/auth_model.dart';

class CreatePostWebServices {
  late Dio dio;
  CreatePostWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// [postData] : a [Map] that contains all data of the post to be created.
  /// `Returns` `true` if post submitted successfully or `false` if an error occured.
  ///
  /// This function Performs `POST` request to the endpoint `baseUrl/post/submit` to submit new post.

  Future<bool> submitPost(Map<String, dynamic> postData) async {
    try {
      print(postData);
      Response response = await dio.post('post/submit',
          data: postData,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> submitPostWeb(Map<String, dynamic> postData) async {
    try {
      if (kDebugMode) {
        print(postData);
      }
      Response response = await dio.post('post/submit',
          data: postData,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      return response;
    } catch (e) {
      return e;
    }
  }

  /// `Returns` [Map] contains key `subreddits` with value as a [List] of subreddits the user joined and `[]` (empty list) if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/subreddit/mine`.
  Future<List<dynamic>> getUserJoinedSubreddits() async {
    try {
      Response response = await dio.get('subreddit/join/me',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getUserModSubreddits() async {
    try {
      Response response = await dio.get('subreddit/moderation/me',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<String> postImageAndVideo(String postId, Uint8List media) async {
    try {
      FormData formData = FormData.fromMap({
        "icon": MultipartFile.fromBytes(media,
            contentType: MediaType('application', 'json'), filename: 'photo')
      });
      Response response = await dio.post('post/$postId/upload-media',
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint(
          "update picture status code ${response.statusCode.toString()} new image link : ${response.data}");
      return response.data['status'] ?? 'failed';
    } catch (e) {
      debugPrint(e.toString());
      return 'failed';
    }
  }
}
