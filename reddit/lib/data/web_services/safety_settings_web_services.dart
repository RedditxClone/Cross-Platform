import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

// This class is responsible of making request to the server
class SafetySettingsWebServices {
  late Dio dio;
  bool isMockerServer = useMockServerForAllWebServices;
  SafetySettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: isMockerServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  /// Returns all user settings : Performs get request to the endpoint /prefs to get all user settings from the API
  Future<dynamic> getUserSettings() async {
    try {
      Response response = await dio.get('prefs');
      return response.data;
    } catch (e) {
      return null;
    }
  }

  /// patch request to update cover and profile photo
  Future<String> updateImage(String key, value) async {
    try {
      Response response = await dio.patch('prefs', data: {key: value});
      return response.data;
    } catch (e) {
      return '';
    }
  }

  /// patch request to updates any user settings
  Future<int> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('prefs', data: changed);
      print('status code : ${response.statusCode}');
      return response.statusCode!;
    } catch (e) {
      return 400;
    }
  }

  /// get request to check if the username available. used in safety settings to block someone
  Future<dynamic> checkUsernameAvailable(String username) async {
    try {
      Response response = await dio.post('user/check-available-username',
          queryParameters: {'username': username});
      return response.statusCode;
    } catch (e) {
      return null;
    }
  }

  /// get request to get user's blocked list
  Future<dynamic> blockUser(String username) async {
    try {
      Response response =
          await dio.post('user/1/block', data: {'username': username});
      return response.statusCode;
    } catch (e) {
      return [];
    }
  }

  /// get request to get user's blocked list
  Future<dynamic> unBlockUser(String username) async {
    try {
      Response response =
          await dio.post('user/1/unblock', data: {'username': username});
      return response.statusCode;
    } catch (e) {
      return [];
    }
  }

  /// get request to get user's blocked list
  Future<dynamic> getBlockedUsers() async {
    try {
      Response response = await dio.get('user/block');
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
