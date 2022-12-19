import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class CommentsWebServices {
  late Dio dio;
  CommentsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// `Returns` the comment that are children (replies) to a post or comment.
  /// This function performs `GET` request to the endpoint `thing/{PostID or CommentID}/with-children`.
  Future<dynamic> getThingComments(String id) async {
    try {
      // Get random posts if the user is not signed in (Without token)
      // Get joined communities posts if the user is signed in (With token)
      Response response = UserData.user == null
          ? await dio.get('thing/$id/with-children')
          : await dio.get('thing/$id/with-children',
              options: Options(
                headers: {"Authorization": "Bearer ${UserData.user!.token}"},
              ));
      debugPrint("Comments status code in web services ${response.statusCode}");
      // debugPrint("${response.data}");
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          debugPrint(
              "Error in comments, status code ${e.response!.statusCode!}");
          if (e.response!.statusCode == 403) {
            debugPrint("Unauthorized");
          }
          debugPrint("${e.response!.data}");
        }
        debugPrint("$e");
      } else {
        debugPrint("$e");
      }
      return [];
    }
  }
}
