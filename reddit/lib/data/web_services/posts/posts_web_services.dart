import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class PostsWebServices {
  bool useMockServer = false;
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
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = UserData.user == null
          ? await dio.get('post/timeline')
          : await dio.get('post/timeline',
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ));
      // debugPrint("Timeline posts in web services ${response.data}");
      debugPrint(
          "Timeline posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 403) {
          print("Unauthorized");
        }
        debugPrint("Status code is ${e.response!.statusCode!}");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// `Returns` home page posts.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getMyProfilePosts() async {
    try {
      Response response = await dio.get('post/me',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("posts in web services ${response.data}");
      debugPrint("posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 403) {
          print("Unauthorized");
        }
        debugPrint("Status code is ${e.response!.statusCode!}");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }
}
