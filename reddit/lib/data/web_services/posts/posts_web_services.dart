import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';

class PostsWebServices {
  bool useMockServer = true;
  // Mock URL For Postman
  final dummyToken = "";
  String mockUrl =
      "https://a8eda59d-d8f3-4ef2-9581-29e6473824d9.mock.pstmn.io/";
  late Dio dio;
  PostsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// `Returns` home page posts.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getPosts() async {
    try {
      Response response = await dio.get('home/posts');
      // debugPrint(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "Error in posts web services";
    }
  }
}
