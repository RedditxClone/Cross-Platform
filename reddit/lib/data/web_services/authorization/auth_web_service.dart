import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/helper/dio.dart';

class AuthWebService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://github.com/login/oauth/',
      receiveDataWhenStatusError: true,
      sendTimeout: 5000,
      receiveTimeout: 5000,
    ),
  );

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server to sign up the user.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future signup(String password, String username, String email) async {
    try {
      var res = await DioHelper.postData(url: 'auth/signup', data: {
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
      var res = await DioHelper.postData(url: 'auth/login', data: {
        "username": username,
        "password": password,
      });
      // debugPrint("from login ${res.statusCode}");
      return res;
    } on DioError catch (e) {
      debugPrint("from login $e");
      return e.response;
    }
  }

  /// [googleToken] : The token of the user from google.
  ///
  /// This function makes the request to the server to login the user with google.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future loginWithGoogle(String googleToken) async {
    try {
      var res = await DioHelper.postData(url: 'auth/google', data: {
        "token": googleToken,
      });
      return res;
    } on DioError catch (e) {
      debugPrint("from login $e");
      return e.response;
    }
  }

  /// [googleToken] : The token of the user from google.
  ///
  /// This function makes the request to the server to login the user with google.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future loginWithGitHub(String googleToken) async {
    try {
      var res = _dio.get('authorize?client_id=$gitHubClientID');
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
    try {
      var res = await DioHelper.postData(url: 'auth/forget-password', data: {
        "username": username,
      });
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
  }

  // Future changeForgottenPassword(
  //     String password, String username, String token) async {
  //   var res =
  //       await DioHelper.postData(url: 'auth/change-forgotten-password', data: {
  //     "password": password,
  //   });
  //   return res;
  // }

  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server if the user requested to get his username.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future forgetUsername(String email) async {
    try {
      var res = await DioHelper.postData(url: 'auth/forget-username', data: {
        "email": email,
      });
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
  }

  /// This function makes the request to random usernames to suggested to the user.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  ///
  /// Returns the response from the server.
  Future getSuggestedUsernames() async {
    try {
      var res =
          await DioHelper.getData(url: "user/random-usernames", query: {});
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
  }

  /// [username] : The username of the user.
  ///
  /// This function makes the request to check on the username if t's avialable for the user.
  /// This function calls the function [DioHelper.postData] which makes the request to the server.
  /// Returns the response from the server.
  Future checkOnUsername(String username) async {
    try {
      var res =
          await DioHelper.postData(url: 'user/check-available-username', data: {
        'username': username,
      });
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
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
        url: 'user/me/$key',
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      debugPrint("res of img = ${response.statusCode}");
      return response;
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
    try {
      var res = await DioHelper.patchData(
          url: 'user/me/prefs',
          data: selectedInterests,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
  }

  /// [token] : [String] which is The token of the user.
  /// [gender] : [String] the gender selected by the user
  ///
  /// This function makes the request to udate the user gender during signup.
  /// Returns the response data from the server.
  Future genderInSignup(String gender, String token) async {
    try {
      var res = await DioHelper.patchData(
          url: 'user/me/prefs',
          data: {
            "gender": gender,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
  }

  /// [token] : [String] which is The id of the user.
  ///
  /// get the user data with userId
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  /// Returns the response data from the server.
  Future getUserData(String token) async {
    try {
      var res = await DioHelper.getDataWithHeaders(
          url: 'user/me',
          query: {},
          headers: {
            "Authorization": "Bearer $token",
          });
      return res;
    } on DioError catch (e) {
      debugPrint("from dio $e");
      return e.response;
    }
  }
}
