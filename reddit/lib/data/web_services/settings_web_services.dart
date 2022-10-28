import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/profile_settings.dart';

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
  Future<dynamic> getProfileSettings() async {
    try {
      Response response = await dio.get('prefs');
      // print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return ProfileSettings();
    }
  }
}
