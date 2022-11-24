import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../model/signin.dart';
import '../web_services/authorization/signup_web_servide.dart';

class SignupRepo {
  final SignupWebService signupWebService;
  User? user;
  SignupRepo(this.signupWebService);

  Future<User?> signup(String password, String username, String email) async {
    await signupWebService.signup(password, username, email).then((value) {
      if (value.statusCode == 201) {
        user = User.fromJson(value.data);
      } else {
        debugPrint("user is null $user");
        user = null;
      }
    });
    return user;
  }

  Future<dynamic> updateImageWeb(String key, Uint8List fileAsBytes) async {
    final newVal = await signupWebService.updateImageWeb(fileAsBytes, key,
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNzI0ZjQ3NTg0NmUxM2VmZjg4MDkxOSIsImlhdCI6MTY2ODQ0Njk1MSwiZXhwIjoxNjY5MzEwOTUxfQ.GuYEH3ZpIrMQxdzhYGIJGxCDTCyyesPaidIPOYNRQOA');
    debugPrint("from repo ${newVal[key]}");
    return newVal[key];
  }
}
