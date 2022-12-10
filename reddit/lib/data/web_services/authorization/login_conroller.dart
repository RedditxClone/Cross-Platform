import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:oauth2/oauth2.dart' as oauth2;
import'package:flutter/services.dart';
class GoogleSingInApi {
  static const clientIdWeb =
      '731962970730-93vd9ao2c9ckhmguioje6ar6jmjk3cic.apps.googleusercontent.com';
  static const clientIdAndroid =
      '731962970730-eogvrnvtmkq777vvd7s5gumlguqql9o2.apps.googleusercontent.com';
  static final GoogleSignIn _googleSignInMob = GoogleSignIn();
  static final GoogleSignIn googleSignInWeb = GoogleSignIn(
    clientId: clientIdWeb,
  );

  static Future<GoogleSignInAccount?> loginMob() {
    // _googleSignInMob.signOut();
    return _googleSignInMob.signIn();
  }

  static Future<GoogleSignInAccount?> loginMobSilently() {
    _googleSignInMob.signOut();
    return _googleSignInMob.signInSilently();
  }

  static Future<GoogleSignInAccount?> loginWebSilently() {
    return googleSignInWeb.signInSilently();
  }

  static Future<GoogleSignInAccount?> logoutMob() => _googleSignInMob
      .signOut(); //this signout is for mobile but it saves your account`
  static Future<GoogleSignInAccount?> signoutMob() => _googleSignInMob
      .disconnect(); //this signout is for mobile and it deletes your account

  static Future<GoogleSignInAccount?> loginWeb() async {
    return await googleSignInWeb.signIn();
  }

  static Future<GoogleSignInAccount?> logoutWeb() => googleSignInWeb.signOut();
  static Future<GoogleSignInAccount?> signoutWeb() =>
      googleSignInWeb.disconnect();

  static Future<bool> checkIfSignedIn() async {
    if (kIsWeb) {
      return googleSignInWeb.isSignedIn();
    }
    return _googleSignInMob.isSignedIn();
  }

  static Future<String?> getGoogleToken() async {
    String? token;
    if (kIsWeb) {
      token = await googleSignInWeb.currentUser?.authentication
          .then((value) => value.idToken);
    } else {
      var x = await _googleSignInMob.currentUser?.authentication;
      token = x?.accessToken;
    }
    return token;
  }
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

class GithubAuthenticator {
  // CredentialsStorage? _credentialsStore;
  var x ="dadsad";
  var  y = Uri.parse('adsad');
}