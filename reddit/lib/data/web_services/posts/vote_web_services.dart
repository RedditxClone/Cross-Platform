import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class VoteWebServices {
  late Dio dio;
  VoteWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
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
        debugPrint("Error in up vote, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
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
        debugPrint(
            "Error in down vote, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
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
        debugPrint("Error in unvote, status code ${e.response!.statusCode!}");
        if (e.response!.statusCode == 403) {
          debugPrint("Unauthorized");
        }
      } else {
        debugPrint("$e");
      }
      return {};
    }
  }
}
