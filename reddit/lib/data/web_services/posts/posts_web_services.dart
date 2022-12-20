import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class PostsWebServices {
  bool useMockServer = false;
  // Mock URL For Postman
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
  Future<dynamic> getTimelinePosts(String sort, int page, int limit) async {
    try {
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = UserData.user == null
          ? await dio.get('post/timeline',
              queryParameters: {"sort": sort, "page": page, "limit": limit})
          : await dio.get('post/timeline',
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ),
              queryParameters: {"sort": sort, "page": page, "limit": limit});
      // debugPrint("Timeline posts in web services ${response.data}");
      debugPrint(
          "Timeline posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in timeline posts, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// `Returns` popular page posts.
  /// This function performs `GET` request to the endpoint `baseUrl+post/popular`.
  Future<dynamic> getPopularPosts(String sort, int page, int limit) async {
    try {
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = UserData.user == null
          ? await dio.get('post/popular',
              queryParameters: {"sort": sort, "page": page, "limit": limit})
          : await dio.get('post/popular',
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ),
              queryParameters: {"sort": sort, "page": page, "limit": limit});
      // debugPrint("Timeline posts in web services ${response.data}");
      debugPrint(
          "Popular posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in popular posts, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// `Returns` user profile posts.
  /// This function performs `GET` request to the endpoint `baseUrl+user/{user_id}/posts`.
  Future<dynamic> getUserPosts(
      String id, String sort, int page, int limit) async {
    try {
      Response response = UserData.user == null
          ? await dio.get('user/$id/posts',
              queryParameters: {"sort": sort, "page": page, "limit": limit})
          : await dio.get('user/$id/posts',
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ),
              queryParameters: {"sort": sort, "page": page, "limit": limit});
      debugPrint(
          "User posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in user posts, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }

  /// `Returns` home page posts.
  /// This function performs `GET` request to the endpoint ``.
  Future<dynamic> getMyProfilePosts(String sort, int page, int limit) async {
    try {
      Response response = await dio.get('post/me',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ),
          queryParameters: {"sort": sort, "page": page, "limit": limit});
      // debugPrint("posts in web services ${response.data}");
      debugPrint("posts status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        debugPrint(
            "Error in profile posts, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }
}
