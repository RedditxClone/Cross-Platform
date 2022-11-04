import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

// This class is responsible of making request to the server
class SafetySettingsWebServices {
  late Dio dio;
  // String mockUrl = TargetPlatform.android == defaultTargetPlatform
  //     ? "http://10.0.2.2:3000/"
  //     : "http://127.0.0.1:3000/";
  String mockUrl =
      'https://ee2e6548-8637-491e-ac9f-5109ed246fd1.mock.pstmn.io/';
  bool isMockerServer = true;
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
      return '';
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
  Future<String> updatePrefs(Map changed) async {
    try {
      Response response = await dio.patch('prefs', data: changed);
      return response.data;
    } catch (e) {
      return '';
    }
  }
}
