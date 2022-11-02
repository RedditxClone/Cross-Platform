import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';

class AccountSettingsWebServices {
  bool useMockServer = true;
  String mockUrl = TargetPlatform.android == defaultTargetPlatform
      ? "http://10.0.2.2:3001/"
      : "http://127.0.0.1:3001/";
  // String mockUrl = "http://127.0.0.1:3001/";
  late Dio dio;
  AccountSettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
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
      print(e);
      return "";
    }
  }

  Future<int> updateAccountSettings(Map<String, dynamic> newAccSettings) async {
    try {
      Response response = await dio.patch(
        'user/me/prefs',
        data: newAccSettings,
      );
      if (response.statusCode == 200) {
        print("Account settings updated successfully");
      } else {
        print("Failed to updateAccount settings");
      }
      return response.statusCode!;
    } catch (e) {
      print(e);
      return 404;
    }
  }

  Future<int> changePassword(Map<String, dynamic> changePasswordMap) async {
    try {
      Response response = await dio.patch(
        'auth/change_password',
        data: changePasswordMap,
      );
      if (response.statusCode == 200) {
        print("Password changed successfully");
      } else if (response.statusCode == 403) {
        print("Wrong password");
      } else if (response.statusCode == 401) {
        print("Unauthorized");
      }
      return response.statusCode!;
    } catch (e) {
      print(e);
      if (e is DioError) {
        if (e.response!.statusCode == 403) {
          print("Wrong password");
        } else if (e.response!.statusCode == 401) {
          print("Unauthorized");
        }
        return e.response!.statusCode!;
      }
      return 404;
    }
  }
}
