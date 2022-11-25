// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';

/// Web Services for Getting 10 Random Posts
class DiscoverPageWebServices {
  late Dio dio;

  ///Setting Dio Options.
  DiscoverPageWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://5594ecfb-f6d5-4000-82b3-2590d4e20e97.mock.pstmn.io/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllRandomPosts() async {
    try {
      Response response = await dio.get('discover/randomposts');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
