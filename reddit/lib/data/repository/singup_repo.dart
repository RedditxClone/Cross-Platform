import 'package:flutter/material.dart';

import '../model/signin.dart';
import '../web_services/authorization/signup_web_servide.dart';

class SignupRepo {
  final SignupWebService signupWebService;
  late User? user;
  SignupRepo(this.signupWebService);

  Future<User?> signup(String password, String username, String email) async {
    await signupWebService.signup(password, username, email).then((value) {
      if (value.statusCode == 201) {
        user = User.fromJson(value.data);
      } else {
        debugPrint(user.toString());
        user = null;
      }
    });
    return user;
  }
}
