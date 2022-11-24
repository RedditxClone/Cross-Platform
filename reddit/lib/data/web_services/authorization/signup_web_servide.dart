import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/helper/dio.dart';

class SignupWebService {
  Future signup(String password, String username, String email) async {
    var res = await DioHelper.postData(url: '/api/auth/signup', data: {
      "password": password,
      "name": username,
      "email": email,
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
        options: null, 
      );
      /*Options(
            headers: {"Authorization": "Bearer $token"},
          ) */
      debugPrint("res of img = ${response.statusCode}");
      return response.data;
    } catch (e) {
      debugPrint("error in image web ${e.toString()}");
      return '';
    }
  }
}
