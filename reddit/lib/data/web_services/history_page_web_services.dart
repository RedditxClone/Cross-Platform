import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class HistoryPageWebServices {
  late Dio dio;
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
  Future<dynamic> getPostsInHistoryPage(String mode) async {
    try {
      Response response = mode == 'hidden'
          ? await dio.get("post/hidden",
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ))
          : await dio.get("thing/$mode",
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ));

      return response.data;
    } catch (e) {
      return [];
    }
  }
}
