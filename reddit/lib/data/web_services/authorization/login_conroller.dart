import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../constants/strings.dart';

class GoogleSingInApi {
  static const clientIdWeb =
      '258926482200-nqgr054pn2id7ji7psq605f5eetbaj2j.apps.googleusercontent.com';
  static const clientIdAndroid =
      '493735178109-3ot7lr4vm8ibspfpup1m03m11a9irt57.apps.googleusercontent.com';
  static final GoogleSignIn _googleSignInMob = GoogleSignIn(
    clientId: clientIdAndroid,
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  static final GoogleSignIn _googleSignInWeb = GoogleSignIn(
    clientId: clientIdWeb,
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future<GoogleSignInAccount?> loginMob() => _googleSignInMob.signIn();
  static Future<GoogleSignInAccount?> logoutMob() => _googleSignInMob
      .signOut(); //this signout is for mobile but it saves your account`
  static Future<GoogleSignInAccount?> signoutMob() => _googleSignInMob
      .disconnect(); //this signout is for mobile and it deletes your account

  static Future<GoogleSignInAccount?> loginWeb() => _googleSignInWeb.signIn();
  static Future<GoogleSignInAccount?> logoutWeb() => _googleSignInWeb.signOut();
  static Future<GoogleSignInAccount?> signoutWeb() =>
      _googleSignInWeb.disconnect();
}

// class FacebookSignInApi {
//   static void init() async {
//     // check if is running on Web
//     if (kIsWeb) {
//       // initialiaze the facebook javascript SDK
//       await FacebookAuth.i.webAndDesktopInitialize(
//         appId: FACEBOOK_APP_ID,
//         cookie: true,
//         xfbml: true,
//         version: "v14.0",
//       );
//     }
//   }

  // static Future<LoginResult?> login() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   if (result.status == LoginStatus.success) {
  //     // you are logged
  //     return result;
  //   }
  //   // print(result.status);
  //   // print(result.message);
  //   return null;
  // }

  // static void logout() async {
  //   await FacebookAuth.instance.logOut();
  // }

  // static Future<Map<String, dynamic>> getUserData() async {
  //   final userMap = await FacebookAuth.instance
  //       .getUserData(fields: "id,name,email,picture");
  //   return userMap;
  // }
// }
