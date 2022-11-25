import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../model/signin.dart';
import '../web_services/authorization/auth_web_service.dart';

class AuthRepo {
  final AuthWebService authWebService;
  User? user;
  AuthRepo(this.authWebService);

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

  Future<User?> login(String password, String username) async {
    var res = await authWebService.login(password, username);
    if (res.statusCode == 201) {
      user = User.fromJson(res.data);
    } else {
      user = null;
    }
    return user;
  }

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

  Future<bool> checkOnUsername(String username) async {
    var res = await authWebService.checkOnUsername(username);
    if (res.statusCode == 201) {
      debugPrint("username is available");
      return res.data['status'] as bool;
    } else {
      return false;
    }
  }

  Future<List<String>> getSuggestedUsernames() async {
    var res = await authWebService.getSuggestedUsernames();
    debugPrint("suggested usernames: ${res.data.toString()}");
    if (res.statusCode == 200) {
      return List<String>.from(res.data);
    } else {
      return [];
    }
  }

  Future<dynamic> updateImageWeb(String key, Uint8List fileAsBytes) async {
    final newVal = await authWebService.updateImageWeb(fileAsBytes, key,
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNzI0ZjQ3NTg0NmUxM2VmZjg4MDkxOSIsImlhdCI6MTY2ODQ0Njk1MSwiZXhwIjoxNjY5MzEwOTUxfQ.GuYEH3ZpIrMQxdzhYGIJGxCDTCyyesPaidIPOYNRQOA');
    debugPrint("from repo ${newVal[key]}");
    return newVal[key];
  }
}
