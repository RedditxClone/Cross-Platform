// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

/// Web Services for Getting 10 Random Posts
class DiscoverPageWebServices {
  late Dio dio;
  //String? token = UserData.user!.token;
  String mockUrl =
      "https://5594ecfb-f6d5-4000-82b3-2590d4e20e97.mock.pstmn.io/";

  ///Setting Dio Options.
  DiscoverPageWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: mockUrl, //baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllRandomPosts() async {
    try {
      Response response = await dio.get('post/discover');
      // Response response = await dio.get('post/discover',options: Options(headers: {"Authorization": "Bearer $token"},));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
