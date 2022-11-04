import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';

class EmailSettingsWebServices {
  bool useMockServer = true;
  String mockUrl =
      "https://f1c179b0-0158-4a47-ba39-7b803b8ae58a.mock.pstmn.io/";
  late Dio dio;
  EmailSettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getEmailSettings() async {
    try {
      Response response = await dio.get('user/me/prefs');
      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<void> updateEmailSettings(
      Map<String, dynamic> newEmailSettings) async {
    try {
      Response response = await dio.patch(
        'user/me/prefs',
        data: newEmailSettings,
      );
      if (response.statusCode == 200) {
        print("updated Email settings");
      } else {
        print("Failed to update Email settings");
      }
    } catch (e) {
      print(e);
    }
  }
}
