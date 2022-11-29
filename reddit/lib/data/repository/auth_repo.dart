import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../model/auth_model.dart';
import '../web_services/authorization/auth_web_service.dart';

class AuthRepo {
  final AuthWebService authWebService;
  User? user;
  AuthRepo(this.authWebService);
  /// This function makes the request to the server to sign up the user.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.signup] which makes the request to the server.
  ///
  /// [username]: The username of the user.
  /// [password]: The password of the user.
  /// [email]: The email of the user.
  Future<User?> signup(String password, String username, String email) async {
    await authWebService.signup(password, username, email).then((value) {
      if (value.statusCode == 201) {
        user = User.fromJson(value.data);
        debugPrint("after emitting signup ${user?.name}");
      } else {
        debugPrint("user is null $user");
        user = null;
      }
    });
    return user;
  }
  /// This function makes the request to the server to log in the user.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.login] which makes the request to the server.
  ///
  /// [username]: The username of the user.
  /// [password]: The password of the user.
  Future<User?> login(String password, String username) async {
    var res = await authWebService.login(password, username);
    if (res.statusCode == 201) {
      user = User.fromJson(res.data);
    } else {
      user = null;
    }
    return user;
  }
  /// This function makes the request to the server to let the user change password if he forget it.
  /// This function calls the function [AuthWebService.forgetPassword] which makes the request to the server.
  Future forgetPassword(String username) async {
    var res = await authWebService.forgetPassword(username);
    return res;
  }

  Future changeForgottenPassword(
      String password, String username, String token) async {
    var res =
        await authWebService.changeForgottenPassword(password, username, token);
    return res;
  }
  /// This function makes the request to the server to check on the username if it is available or not.
  /// and checks on the status code if 201 then it's avialable and if it's not 201 so the username isn't avialable.
  /// This function calls the function [AuthWebService.checkOnUsername] which makes the request to the server.
  /// 
  /// Returns [bool]: if the username is available so it's true and false if it's not.
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
/// Returns [List<String>]: a list of random usernames if the status code is 200 and empty list in case of status code isn't 200.
  Future<List<String>> getSuggestedUsernames() async {
    var res = await authWebService.getSuggestedUsernames();
    debugPrint("suggested usernames: ${res.data.toString()}");
    if (res.statusCode == 200) {
      return List<String>.from(res.data);
    } else {
      return [];
    }
  }
/// This function makes the request to the server to get the user's profile picture.
/// 
/// Returns [String]: it restuns a string which the link of the profile picture on the server.
  Future<dynamic> updateImageWeb(String key, Uint8List fileAsBytes) async {
    final newVal = await authWebService.updateImageWeb(fileAsBytes, key,
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNzI0ZjQ3NTg0NmUxM2VmZjg4MDkxOSIsImlhdCI6MTY2ODQ0Njk1MSwiZXhwIjoxNjY5MzEwOTUxfQ.GuYEH3ZpIrMQxdzhYGIJGxCDTCyyesPaidIPOYNRQOA');
    debugPrint("from repo ${newVal[key]}");
    return newVal[key];
  }
}
