import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/user_settings.dart';

class SettingsWebServices {
  late Dio dio;
  SettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  /// ### Returns all user settings
  /// Performs get request to the endpoint /prefs to get all user settings from the API
  Future<dynamic> getProfileSettings() async {
    try {
      Response response = await dio.get('prefs');
      return response.data;
    } catch (e) {
      print(e.toString());
      return Settings();
    }
  }
}
