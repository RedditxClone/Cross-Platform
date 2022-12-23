import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUri);

class GoogleSingInApi {
  static const clientIdWeb =
      '731962970730-93vd9ao2c9ckhmguioje6ar6jmjk3cic.apps.googleusercontent.com';
  static const clientIdAndroid =
      '731962970730-eogvrnvtmkq777vvd7s5gumlguqql9o2.apps.googleusercontent.com';
  static final GoogleSignIn _googleSignInMob =
      GoogleSignIn(clientId: clientIdAndroid);
  static final GoogleSignIn googleSignInWeb = GoogleSignIn(
    clientId: clientIdWeb,
  );

  static Future<GoogleSignInAccount?> loginMob() async {
    return await _googleSignInMob.signIn();
  }

  // static Future<GoogleSignInAccount?> loginMobSilently() async {
  //   return await _googleSignInMob.signInSilently(reAuthenticate: true);
  // }

  // static Future<GoogleSignInAccount?> loginWebSilently() {
  //   return googleSignInWeb.signInSilently();
  // }

  static Future<GoogleSignInAccount?> logoutMob() {
    return _googleSignInMob.signOut();
  } //this signout is for mobile but it saves your account`

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
      return await googleSignInWeb.isSignedIn();
    }
    return await _googleSignInMob.isSignedIn();
  }

  static Future<String?> getGoogleToken() async {
    String? token;
    if (kIsWeb) {
      token = await googleSignInWeb.currentUser?.authentication
          .then((value) => value.idToken);
    } else {
      token = await _googleSignInMob.currentUser?.authentication
          .then((value) => value.idToken);
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

// class GithubOAuthHttpClient extends http.BaseClient {
//   final httpClient = http.Client();
//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers['Accept'] = 'application/json';
//     return httpClient.send(request);
//   }
// }

// class GithubAuthenticator {
//   static final _authEndPoint =
//       Uri.parse("https://github.com/login/oauth/authorize/");
//   static final _tokenEndPoint =
//       Uri.parse('https://github.com/login/oauth/access_token');
//   static final _redirectUrl = Uri.parse('http://localhost:5000/');
//   static const _clientId = '278e3e6f443383001225';
//   static const _clientSecret = 'a2a6752bbb770e154eee440ad54086e76786980e';
//   static const _scopes = ['read:user', 'repo'];
//   static final _revocationEndPoint =
//       Uri.parse('www.api.github.com/applications/$_clientId/token');

//   static final Dio _dio = Dio();
//   static late AuthorizationCodeGrant _grant;
//   static late Credentials _credentials;

//   static void createGrant() {
//     _grant = AuthorizationCodeGrant(
//       _clientId,
//       _authEndPoint,
//       _tokenEndPoint,
//       secret: _clientSecret,
//       httpClient: GithubOAuthHttpClient(),
//     );
//   }

//   static Uri getAuthorizationUrl() {
//     final authorizationUrl =
//         _grant.getAuthorizationUrl(_redirectUrl, scopes: _scopes);
//     debugPrint("auth url is $authorizationUrl");
//     return authorizationUrl;
//   }

//   static Future<String?> getAccessToken(
//       Map<String, String> queryParameters) async {
//     try {
//       Client httpClient =
//           await _grant.handleAuthorizationResponse(queryParameters);
//       _credentials = httpClient.credentials;
//       _grant.close();
//       return _credentials.accessToken;
//     } catch (e) {
//       debugPrint("from github auth: $e");
//       return null;
//     }
//   }

//   static Future<int> logout() async {
//     try {
//       final userNameAndPassword =
//           base64.encode(utf8.encode('$_clientId:$_clientSecret'));
//       var res = await _dio.deleteUri(
//         _revocationEndPoint,
//         data: {
//           'access_token': _credentials.accessToken,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'basic $userNameAndPassword',
//           },
//         ),
//       );
//       return res.statusCode ?? 0;
//     } on DioError catch (e) {
//       debugPrint("from github logout: $e");
//       return e.response?.statusCode ?? 0;
//     }
//   }
// }
