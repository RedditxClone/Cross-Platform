import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:test/data/models/facebook_auth_model.dart';
// import 'package:test/ui/screens/question.dart';

// import '../../data/models/facebook_signin_model.dart';

import '../../../helper/dio.dart';
import '../../../data/model/google_signin.dart';
import '../../../helper/utils/shared_pref.dart';
import '../../../helper/utils/shared_keys.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    "id",
    "email",
    "firstName",
    "lastName",
    "picture",
    'https://lavie.orangedigitalcenteregypt.com/api/v1/docs#/auth/googleAuth',
  ],
);
Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}
