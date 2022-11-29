import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

class CreateCommunityWebServices {
  late Dio dio;
  CreateCommunityWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// Sends create community request to the server, the repository calls this function
  Future<bool> createCommunity(Map<String, dynamic> communityData) async {
    try {
      Response response = await dio.post('/api/subreddit', data: communityData);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioError {
      return false;
    }
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    try {
      Response response = await dio.get(
        '/api/subreddit/r/$subredditName/available',
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError {
      return false;
    }
  }
}
