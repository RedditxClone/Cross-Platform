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
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}
// class LoginController extends GetxController {
//   final _googleSignIn = GoogleSignIn();

//   googleSignIn(BuildContext context) async {
//     final user = await _googleSignIn.signIn();
//     // to get user google token // final ggAuth = await user!.authentication;
//     if (user == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Sign in Failed")));
//     } else {
//       showCustomDialog();
//       await DioHelper.postData(
//         url: '/api/v1/auth/google',
//         data: {
//           "id": user.id.toString(),
//           "email": user.email.toString(),
//           "firstName": user.displayName.toString(),
//           "lastName": user.displayName.toString(),
//           "picture": user.photoUrl.toString(),
//         },
//       ).then((value) async {
//         GoogleSignInModel data = GoogleSignInModel.fromJson(value);
//         await PreferenceUtils.setString(
//             SharedKeys.accessToken.toString(), data.data.accessToken);
//         await PreferenceUtils.setBool(SharedKeys.isLogin.toString(), true);
//         await PreferenceUtils.setString(
//           SharedKeys.signinType.toString(),
//           SharedKeys.signinWithGoogle.toString(),
//         );
//         saveUserInfo();
//         Get.back();
//         bool weeklyTest = await showWeeklyTest();

//         if (weeklyTest) {
//           Get.to(QuestionScreen());
//         } else {
//           Get.to(MainScreen());
//         }
//       }).catchError((e) {
//         print(e);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Sign in Failed"),
//           ),
//         );
//       });
//     }
//   }

//   void googleSignOut() async {
//     showCustomDialog();
//     await _googleSignIn.signOut();
//     await PreferenceUtils.setBool(SharedKeys.isLogin.toString(), false);
//     await PreferenceUtils.setString(
//       SharedKeys.signinType.toString(),
//       SharedKeys.none.toString(),
//     );
//     Get.to(AuthScreen());
//   }

//   Future<void> feacbookSignIn(BuildContext context) async {
//     final LoginResult result = await FacebookAuth.instance.login(
//       permissions: ['email', 'public_profile'],
//     );
//     if (result.status == LoginStatus.success) {
//       // AccessToken? facebookAccessToken = result.accessToken;
//       var userData = await FacebookAuth.instance
//           .getUserData(fields: 'id,name,email,picture');
//       var data = FacebookAuthModel.fromJson(userData);
//       var userEmail = userData['email'] ?? "11ea87519e@boxomail.live";
//       showCustomDialog();
//       await DioHelper.postData(
//         url: '/api/v1/auth/facebook',
//         data: {
//           "id": data.id.toString(),
//           "email": userEmail.toString(),
//           "firstName": data.name.split(' ')[0].toString(),
//           "lastName": data.name.split(' ')[1].toString(),
//           "photo": data.picture.data.url.toString()
//         },
//       ).then((value) async {
//         FacebookSignInModel data = FacebookSignInModel.fromJson(value);
//         print(data.data.accessToken);
//         await PreferenceUtils.setString(
//             SharedKeys.accessToken.toString(), data.data.accessToken);
//         await PreferenceUtils.setBool(SharedKeys.isLogin.toString(), true);
//         await PreferenceUtils.setString(
//           SharedKeys.signinType.toString(),
//           SharedKeys.signinWithFacebook.toString(),
//         );
//         saveUserInfo();
//         Get.back();
//         bool weeklyTest = await showWeeklyTest();

//         if (weeklyTest) {
//           Get.to(QuestionScreen());
//         } else {
//           Get.to(MainScreen());
//         }
//       }).catchError((e) {
//         print(e);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Sign in Failed"),
//           ),
//         );
//       });
//     } else {
//       Get.back();
//       print(result.status);
//       print(result.message);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Sign in Failed"),
//         ),
//       );
//     }
//   }

//   Future<void> facebookSignOut() async {
//     showCustomDialog();
//     await FacebookAuth.instance.logOut();
//     await PreferenceUtils.setBool(SharedKeys.isLogin.toString(), false);
//     await PreferenceUtils.setString(
//       SharedKeys.signinType.toString(),
//       SharedKeys.none.toString(),
//     );
//     Get.to(AuthScreen());
//   }

//   void loginWithApi(BuildContext context, String email, String password) {
//     showCustomDialog();
//     print("start send request ......");
//     DioHelper.postData(
//       url: '/api/v1/auth/signin',
//       data: {"email": email, "password": password},
//     ).then((value) async {
//       print("Done -----------------------------------");
//       print(value);
//       LoginModel data = LoginModel.fromJson(value);
//       print("Done -----------------------------------");
//       await PreferenceUtils.setString(
//           SharedKeys.accessToken.toString(), data.data.accessToken);
//       await PreferenceUtils.setBool(SharedKeys.isLogin.toString(), true);
//       await PreferenceUtils.setString(
//         SharedKeys.signinType.toString(),
//         SharedKeys.signinWithApi.toString(),
//       );
//       saveUserInfo();
//       Get.back();
//       bool weeklyTest = await showWeeklyTest();

//       if (weeklyTest) {
//         Get.to(QuestionScreen());
//       } else {
//         Get.to(MainScreen());
//       }
//     }).catchError((e) {
//       if (e is DioError) {
//         Get.back();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(e.response.toString()),
//           ),
//         );
//       }
//     });
//   }

//   void apiLogOut() async {
//     await PreferenceUtils.setBool(SharedKeys.isLogin.toString(), false);
//     await PreferenceUtils.setString(
//       SharedKeys.signinType.toString(),
//       SharedKeys.none.toString(),
//     );
//     Get.to(AuthScreen());
//   }

//   void logout() async {
//     String signinType =
//         PreferenceUtils.getString(SharedKeys.signinType.toString());
//     if (signinType == SharedKeys.signinWithGoogle.toString()) {
//       googleSignOut();
//     } else if (signinType == SharedKeys.signinWithFacebook.toString()) {
//       facebookSignOut();
//     } else {
//       apiLogOut();
//     }
//   }

//   saveUserInfo() {
//     String accessToken =
//         PreferenceUtils.getString(SharedKeys.accessToken.toString());
//     DioHelper.getDataWithHeaders(
//       url: '/api/v1/user/me',
//       query: {},
//       headers: {"Authorization": "Bearer $accessToken"},
//     ).then((value) async {
//       UserDataModel data = UserDataModel.fromJson(value);
//       await PreferenceUtils.setString(
//         SharedKeys.userName.toString(),
//         "${data.data.firstName} ${data.data.lastName}",
//       );
//       await PreferenceUtils.setString(
//         SharedKeys.userImageLink.toString(),
//         data.data.imageUrl,
//       );
//       await PreferenceUtils.setString(
//         SharedKeys.userPoints.toString(),
//         data.data.userPoints,
//       );
//       await PreferenceUtils.setString(
//         SharedKeys.userPoints.toString(),
//         data.data.userPoints,
//       );
//     });
//   }

//   Future<bool> showWeeklyTest() async {
//     String savedDate = PreferenceUtils.getString(
//       SharedKeys.lastLoginDate.toString(),
//     );
//     if (savedDate.isEmpty) {
//       final dateNow = DateTime.now();
//       await PreferenceUtils.setString(
//         SharedKeys.lastLoginDate.toString(),
//         dateNow.toString(),
//       );
//       return true;
//     } else {
//       final lastQuestionDate = DateTime.parse(savedDate);
//       final dateNow = DateTime.now();

//       final difference = dateNow.difference(lastQuestionDate).inDays;
//       if (difference >= 7) {
//         final dateNow = DateTime.now();
//         await PreferenceUtils.setString(
//           SharedKeys.lastLoginDate.toString(),
//           dateNow.toString(),
//         );
//         return true;
//       }
//       return false;
//     }
//   }
// }
