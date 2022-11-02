// import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:test/data/models/facebook_auth_model.dart';
// import 'package:test/ui/screens/question.dart';

// import '../../data/models/facebook_signin_model.dart';

// import '../../../helper/dio.dart';
// import '../../../data/model/google_signin.dart';
// import '../../../helper/utils/shared_pref.dart';
// import '../../../helper/utils/shared_keys.dart';

class GoogleSingInApi {
  static const clientIdWeb =
      '258926482200-nqgr054pn2id7ji7psq605f5eetbaj2j.apps.googleusercontent.com';
  static final GoogleSignIn _googleSignInMob = GoogleSignIn();
  static final GoogleSignIn _googleSignInWeb =
      GoogleSignIn(clientId: clientIdWeb);

  static Future<GoogleSignInAccount?> loginMob() => _googleSignInMob.signIn();
  static Future<GoogleSignInAccount?> logoutMob() => _googleSignInMob
      .signOut(); //this signout is for mobile but it saves your account
  static Future<GoogleSignInAccount?> signoutMob() => _googleSignInMob
      .disconnect(); //this signout is for mobile and it deletes your account

  static Future<GoogleSignInAccount?> loginWeb() => _googleSignInWeb.signIn();
  static Future<GoogleSignInAccount?> logoutWeb() => _googleSignInWeb.signOut();
  static Future<GoogleSignInAccount?> signoutWeb() =>
      _googleSignInWeb.disconnect();
}
