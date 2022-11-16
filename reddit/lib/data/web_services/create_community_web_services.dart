import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';

class CreateCommunityWebServices {
  bool useMockServer = true;
  String mockUrl = "https://f1c179b0-0158-4a47-ba39-7b803b8ae58a.mock.pstmn.io";
  late Dio dio;
  CreateCommunityWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// Sends create community request to the server, the repository calls this function
  Future<bool> createCommunity(Map<String, dynamic> communityData) async {
    try {
      print(communityData);
      Response response = await dio.post(
        '/api/subreddit',
        data: communityData,
      );
      if (response.statusCode == 201) {
        return true;
      } else {}
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
    }
    return false;
  }
/**
 * 
 */
  Future<bool> getIfNameAvailable(String subredditName) async {
    try {
      Response response = await dio.get(
        '/api/subreddit/r/$subredditName/available',
      );
      if (response.statusCode == 200) {
        return true;
      } else {}
    } catch (e) {
      // debugPrint(e.toString());
    }
    return false;
  }
}
