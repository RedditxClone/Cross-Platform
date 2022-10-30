import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/user_settings.dart';

class SettingsWebServices {
  late Dio dio;
  String mockUrl =
      'https://53abd284-fb16-44a0-9bc9-497fcd7a854d.mock.pstmn.io/';
  bool isMockerServer = true;
  SettingsWebServices() {
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
      print(e.toString());
      return Settings();
    }
  }

  /// updates a user setting
  Future<String> updatePrefs(String key, value) async {
    try {
      Response response = await dio.patch('prefs', data: {key: value});
      return response.data;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}
