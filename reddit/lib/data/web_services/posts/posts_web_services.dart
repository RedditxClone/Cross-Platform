import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class PostsWebServices {
  bool useMockServer = true;
  // Mock URL For Postman
  late String token;
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
    token = UserData.user == null ? "" : UserData.user!.token;
  }

  /// `Returns` home page posts.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getTimelinePosts() async {
    try {
      Response response = await dio.get('post/timeline');
      debugPrint("posts in web services ${response.data}");
      debugPrint("posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// `Returns` home page posts.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getProfilePosts() async {
    try {
      Response response = await dio.get('post/me');
      debugPrint("posts in web services ${response.data}");
      debugPrint("posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
