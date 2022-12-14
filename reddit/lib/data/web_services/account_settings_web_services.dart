import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

import '../model/auth_model.dart';

class AccountSettingsWebServices {
  bool useMockServer = false;
  // Mock URL For Mockoon
  // String mockUrl =` TargetPlatform.android == defaultTargetPlatform
  //     ? "http://10.0.2.2:3001/"
  //     : "http://127.0.0.1:3001/";
  // Mock URL For Postman
  String mockUrl =
      "https://a8eda59d-d8f3-4ef2-9581-29e6473824d9.mock.pstmn.io/";
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

  /// `Returns` the user's account settings if the request is performend successfully or empty string in case of exception
  /// This function performs `GET` request to the endpoint `baseUrl/user/me/prefs` to get all the settings from the API.
  Future<dynamic> getAccountSettings() async {
    try {
      Response response = await dio.get('user/me/prefs',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      print(response.data);
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 403) {
          print("Wrong password");
        } else if (e.response!.statusCode == 401) {
          print("Unauthorized");
        }
      }
      print(e);
      return "";
    }
  }

  /// [newAccSettings] : a [Map] that contains changed account settings
  /// `Returns` status code `200` if request is successfull or `401` if an error occured
  /// This function Performs `PATCH` request to the endpoint `baseUrl/user/me/prefs` to update user's account settings.
  Future<int> updateAccountSettings(Map<String, dynamic> newAccSettings) async {
    try {
      Response response = await dio.patch('user/me/prefs',
          data: newAccSettings,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
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

  /// [changePasswordMap] : a [Map] that contains changed password
  /// Returns status code `200` if request is successfull or `401` if Unauthorized or `403` if Wrong password
  /// This function Performs `PATCH` request to the endpoint `baseUrl/auth/change_password`.
  Future<int> changePassword(Map<String, dynamic> changePasswordMap) async {
    try {
      Response response = await dio.patch('auth/change-password',
          data: changePasswordMap,
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
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
