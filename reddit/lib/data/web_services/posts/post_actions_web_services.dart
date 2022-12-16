import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class PostActionsWebServices {
  late Dio dio;
  PostActionsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// Save a post.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/save`.
  Future<dynamic> savePost(String id) async {
    try {
      Response response = await dio.post('post/$id/save',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Save status code ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Error in save, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
        return e.response!.statusCode!;
      } else {
        debugPrint("$e");
      }
      return 404;
    }
  }

  /// Unsave a saved post.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/unsave`.
  Future<dynamic> unsavePost(String id) async {
    try {
      Response response = await dio.post('post/$id/unsave',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Unsave status code ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Error in unsave, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
        return e.response!.statusCode!;
      } else {
        debugPrint("$e");
      }
      return 404;
    }
  }

  /// Mark a post as spam.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/spam`.
  Future<dynamic> spamPost(String id) async {
    try {
      Response response = await dio.post('post/$id/spam',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Spam status code ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Error in Spam, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
        return e.response!.statusCode!;
      } else {
        debugPrint("$e");
      }
      return 404;
    }
  }

  /// Hide a post.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/hide`.
  Future<dynamic> hidePost(String id) async {
    try {
      Response response = await dio.post('post/$id/hide',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Hide status code ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Error in hide, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
        return e.response!.statusCode!;
      } else {
        debugPrint("$e");
      }
      return 404;
    }
  }

  /// Hide a post.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/hide`.
  Future<dynamic> deletePost(String id) async {
    try {
      Response response = await dio.delete('post/$id',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Delete status code ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint("Error in delete, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
          return e.response!.statusCode!;
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return 404;
    }
  }

  /// Unhide a hideen post.
  /// This function performs `POST` request to the endpoint `baseUrl/post/$id/unhide`.
  Future<dynamic> unhidePost(String id) async {
    try {
      Response response = await dio.post('post/$id/unhide',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Unhide status code ${response.statusCode}");
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint("Error in unhide, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
          return e.response!.statusCode!;
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return 404;
    }
  }

  /// `Returns` new votes count.
  /// This function performs `POST` request to the endpoint `baseUrl/thing/${id}/upvote`.
  Future<dynamic> upVote(String id) async {
    try {
      Response response = await dio.post('thing/$id/upvote',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Up vote in web services ${response.data}");
      debugPrint("Up vote status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in up vote, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return {};
    }
  }

  /// `Returns` new votes count.
  /// This function performs `POST` request to the endpoint `baseUrl/thing/${id}/downvote`.
  Future<dynamic> downVote(String id) async {
    try {
      Response response = await dio.post('thing/$id/downvote',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("Down vote in web services ${response.data}");
      debugPrint(
          "Down vote status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in down vote, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return {};
    }
  }

  /// `Returns` new votes count.
  /// This function performs `POST` request to the endpoint `baseUrl/thing/${id}/downvote`.
  Future<dynamic> unVote(String id) async {
    try {
      Response response = await dio.post('thing/$id/unVote',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      // debugPrint("unvote in web services ${response.data}");
      debugPrint("unVote status code in web services ${response.statusCode}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint("Error in unvote, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return {};
    }
  }
}
