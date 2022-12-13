import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

class UserProfileWebServices {
  bool useMockServer = false;
  String mockUrl =
      "https://a8eda59d-d8f3-4ef2-9581-29e6473824d9.mock.pstmn.io/";

  late Dio dio;
  UserProfileWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// [userId] : the id of user to be followed
  /// `Returns` : [User] info
  Future<dynamic> getUserInfo(String userId) async {
    try {
      Response response = await dio.get('user/$userId',
          options: Options(
            headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
          ));
      print(response.statusCode);
      return response.data;
    } catch (e) {
      if (e is DioError) {
        print(e);
        return "";
      }
    }
  }

  /// [userId] : the id of user to be followed
  /// `Returns` [statusCode] of the request:
  /// - 201: you have followed the user successfully
  /// - 400: either you are following the user or there is a block between you and the user
  /// - 401: user is not logged in
  Future<dynamic> follow(String userId) async {
    try {
      Response response = await dio.post('user/$userId/follow',
          options: Options(
            headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
          ));
      print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        print(e);
        return "";
      }
    }
  }

  /// [userId] : the id of user to be unfollowed
  /// `Returns` [statusCode] of the request:
  /// - 201: you have unfollowed the user successfully
  /// - 400: either you are not following the user or there is a block between you and the user or wrong user id
  /// - 401: user is not logged in
  Future<dynamic> unfollow(String userId) async {
    try {
      Response response = await dio.post('user/$userId/unfollow',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      if (e is DioError) {
        print(e);
        return "";
      }
    }
  }
}
