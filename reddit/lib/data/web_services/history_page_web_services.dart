import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

class HistoryPageWebServices {
  late Dio dio;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODhhNjFiNWUwYjU4M2Y0YTc5ZTQxYSIsImlhdCI6MTY2OTg5OTgwMywiZXhwIjoxNjcwNzYzODAzfQ.19uD_QlcThGaS_lZ0iE92q0771WwJSB2jgWfJPTWkn8";
  HistoryPageWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getPostsInHistoryPage(String userID, String mode) async {
    try {
      Response response = await dio.get("user/$userID/$mode",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      return response.data;
    } catch (e) {
      return [];
    }
  }
}
