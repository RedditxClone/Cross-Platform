import 'package:dio/dio.dart';

class AccountSettingsWebServices {
  late Dio dio;
  AccountSettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://27b4f30c-6ade-4c85-bb05-6a0d3b10ef7c.mock.pstmn.io/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getAccountSettings() async {
    try {
      Response response = await dio.get('user/me/prefs');
      print(response.data);
      return response.data;
    } catch (e) {
      print("null");
      return [];
    }
  }
}
