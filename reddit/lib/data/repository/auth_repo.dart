import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/auth_model.dart';
import '../web_services/authorization/auth_web_service.dart';

class AuthRepo {
  final AuthWebService authWebService;
  User? user;
  AuthRepo(this.authWebService);

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server to sign up the user.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.signup] which makes the request to the server.
  Future<User?> signup(String password, String username, String email) async {
    await authWebService.signup(password, username, email).then((value) {
      if (value.statusCode == 201) {
        user = User.fromJson(value.data);
      } else {
        debugPrint("status code is ${value.statusCode}");
        user = null;
      }
    });
    return user;
  }

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  ///
  /// This function makes the request to the server to log in the user.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.login] which makes the request to the server.
  /// RETURNS [User] : the user data.
  Future<User?> login(String password, String username) async {
    Response res = await authWebService.login(password, username);
    if (res.statusCode == 201) {
      user = User.fromJson(res.data);
    } else {
      user = null;
    }
    return user;
  }

  /// [username] : The username of the user.
  ///
  /// This function makes the request to the server to let the user change password if he forget it.
  /// This function calls the function [AuthWebService.forgetPassword] which makes the request to the server.
  /// Returns [bool] which is true if the email sent successfully and false if it's not.
  Future<bool> forgetPassword(String username) async {
    var res = await authWebService.forgetPassword(username);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server if the user requested to get his username.
  /// This function calls the function [AuthWebService.forgetUsername] which makes the request to the server.
  /// Returns [bool] which is true if the email sent successfully and false if it's not.
  Future<bool> forgetUsername(String email) async {
    var res = await authWebService.forgetUsername(email);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// This function makes the request to the server to check on the username if it is available or not.
  /// and checks on the status code if 201 then it's avialable and if it's not 201 so the username isn't avialable.
  /// This function calls the function [AuthWebService.checkOnUsername] which makes the request to the server.
  ///
  /// Returns [bool] : if the username is available so it's true and false if it's not.
  Future<bool> checkOnUsername(String username) async {
    var res = await authWebService.checkOnUsername(username);
    if (res.statusCode == 201) {
      debugPrint("username is available");
      return res.data['status'] as bool;
    } else {
      return false;
    }
  }

  /// This function makes the request to the server to get random usernames, then it checks on the status code if 200 then it returns the usernames.
  /// This function calls the function [AuthWebService.getSuggestedUsernames] which makes the request to the server.
  ///
  /// Returns [List] : a list of random usernames if the status code is 200 and empty list in case of status code isn't 200.
  Future<List<String>> getSuggestedUsernames() async {
    var res = await authWebService.getSuggestedUsernames();
    debugPrint("suggested usernames: ${res.data.toString()}");
    if (res.statusCode == 200) {
      return List<String>.from(res.data);
    } else {
      return [];
    }
  }

  /// [fileAsBytes] : [Uint8List] which is the image required to be uploaded.
  /// [key] : [String] which is The type of change the user want to make.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to the server to get the user's profile picture.
  /// This function calls the function [AuthWebService.updateImageWeb] which makes the request to the server.
  /// Returns [String] : it restuns a string which the link of the profile picture on the server.
  Future<dynamic> updateImageWeb(
      String key, Uint8List fileAsBytes, String token) async {
    final newVal = await authWebService.updateImageWeb(fileAsBytes, key, token);
    debugPrint("from repo ${newVal[key]}");
    return newVal[key];
  }

  /// [token] : [String] which is The token of the user.
  /// [gender] : [String] the gender selected by the user
  ///
  /// This function makes the request to udate the user gender during signup.
  /// Returns [bool] which is true if the gender updated successfully and false if it's not.
  Future<bool> genderInSignup(String gender, String token) async {
    var res = await authWebService.genderInSignup(gender, token);
    if (res.statusCode == 200) {
      UserData.user?.gender = gender;
      return true;
    } else {
      return false;
    }
  }

  /// [selectedInterests] : [Map] which is the list of the interests selected by the user.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to update the user interests during signup.
  /// Returns [bool] which is true if the interests updated successfully and false if it's not.
  Future<bool> addInterests(
      Map<String, dynamic> selectedInterests, String token) async {
    var res = await authWebService.addInterests(selectedInterests, token);
    if (res.statusCode == 200) {
      UserData.user?.interests = selectedInterests;
      return true;
    } else {
      return false;
    }
  }
}
