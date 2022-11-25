import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/helper/dio.dart';

class AuthWebService {
  Future signup(String password, String username, String email) async {
    var res = await DioHelper.postData(url: '/api/auth/signup', data: {
      "email": email,
      "username": username,
      "password": password,
    });
    return res;
  }

  Future login(String password, String username) async {
    var res = await DioHelper.postData(url: '/api/auth/login', data: {
      "username": username,
      "password": password,
    });
    return res;
  }

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

  Future forgetUsername(String email) async {
    var res = await DioHelper.postData(url: '/api/auth/forget-username', data: {
      "email": email,
    });
    return res;
  }

  Future getSuggestedUsernames() async {
    var res =
        await DioHelper.getData(url: "/api/user/random-usernames", query: {});
    return res;
  }

  Future checkOnUsername(String username) async {
    var res = await DioHelper.postData(
        url: '/api/user/check-available-username',
        data: {
          'username': username,
        });
    return res;
  }

  /// updates a image
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
}
