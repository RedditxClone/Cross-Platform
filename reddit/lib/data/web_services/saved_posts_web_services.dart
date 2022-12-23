// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import '../model/auth_model.dart';

class SavedPostsWebServices {
  late Dio dio;
  String mockUrl =
      "https://595283e6-1374-49a3-abc2-32091303998c.mock.pstmn.io/";

  ///Setting Dio Options.
  SavedPostsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl, // mockUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  dynamic getAllSavedPosts() async {
    try {
      // Response response = await dio.get('user/post/save');
      Response response = await dio.get('user/post/save',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint('status code : ${response.statusCode}');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
