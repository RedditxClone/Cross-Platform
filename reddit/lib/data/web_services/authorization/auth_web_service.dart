import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/helper/dio.dart';

class AuthWebService {
  /// [username] : The username of the user.
  /// [password] : The password of the user.
  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server to sign up the user.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future signup(String password, String username, String email) async {
    try {
      var res = await DioHelper.postData(url: '/api/auth/signup', data: {
        "email": email,
        "username": username,
        "password": password,
      });
      return res;
    } on DioError catch (e) {
      debugPrint("from signup $e");
      return e.response;
    }
  }

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  ///
  /// This function makes the request to the server to login the user.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future login(String password, String username) async {
    try {
      var res = await DioHelper.postData(url: '/api/auth/login', data: {
        "username": username,
        "password": password,
      });
      return res;
    } on DioError catch (e) {
      debugPrint("from login $e");
      return e.response;
    }
  }

  /// [username] : The username of the user.
  ///
  /// This function makes the request to check on the username if it's avialable.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future forgetPassword(String username) async {
    var res = await DioHelper.postData(url: '/api/auth/forget-password', data: {
      "username": username,
    });
    return res;
  }

  Future changeForgottenPassword(
      String password, String username, String token) async {
    var res = await DioHelper.postData(
        url: '/api/auth/change-forgotten-password',
        data: {
          "password": password,
        });
    return res;
  }

  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server if the user requested to get his username.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future forgetUsername(String email) async {
    var res = await DioHelper.postData(url: '/api/auth/forget-username', data: {
      "email": email,
    });
    return res;
  }

  /// This function makes the request to random usernames to suggested to the user.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  ///
  /// Returns the response from the server.
  Future getSuggestedUsernames() async {
    var res =
        await DioHelper.getData(url: "/api/user/random-usernames", query: {});
    return res;
  }

  /// [username] : The username of the user.
  ///
  /// This function makes the request to check on the username if t's avialable for the user.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future checkOnUsername(String username) async {
    var res = await DioHelper.postData(
        url: '/api/user/check-available-username',
        data: {
          'username': username,
        });
    return res;
  }

  /// [fileAsBytes] : [Uint8List] which is the image required to be uploaded.
  /// [key] : [String] which is The type of change the user want to make.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to update the user profile picture during signup.
  /// This function calls the function [DioHelper.patchData] which makes the request to the server.
  /// Returns the response data from the server.
  Future<dynamic> updateImageWeb(
      Uint8List fileAsBytes, String key, String token) async {
    try {
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(fileAsBytes,
            contentType: MediaType('application', 'json'), filename: key)
      });
      Response response = await DioHelper.patchData(
        url: '/user/me/$key',
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      debugPrint("res of img = ${response.statusCode}");
      return response.data;
    } catch (e) {
      debugPrint("error in image web ${e.toString()}");
      return '';
    }
  }

  /// [selectedInterests] : [List] which is the list of the interests selected by the user.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to update the user interests during signup.
  /// Returns the response data from the server.
  Future addInterests(
      Map<String, dynamic> selectedInterests, String token) async {
    var res = await DioHelper.patchData(
        url: '/api/user/me/prefs',
        data: selectedInterests,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    return res;
  }

  /// [token] : [String] which is The token of the user.
  /// [gender] : [String] the gender selected by the user
  ///
  /// This function makes the request to udate the user gender during signup.
  /// Returns the response data from the server.
  Future genderInSignup(String gender, String token) async {
    var res = await DioHelper.patchData(
        url: '/api/user/me/prefs',
        data: {
          "gender": gender,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    return res;
  }
}
