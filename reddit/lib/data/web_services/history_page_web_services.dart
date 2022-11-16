import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

class HistoryPageWebServices {
  bool useMockServer = true;
  String mockUrl =
      "https://f1c179b0-0158-4a47-ba39-7b803b8ae58a.mock.pstmn.io/";
  late Dio dio;
  HistoryPageWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getPostsInHistoryPage(String userID, String mode) async {
    try {
      Response response = await dio.get("/user/$userID/about$mode");
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
