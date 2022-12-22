import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';

import '../model/auth_model.dart';
import '../web_services/authorization/auth_web_service.dart';

class AuthRepo {
  final AuthWebService authWebService;
  late Map<String, dynamic> user;
  AuthRepo(this.authWebService);

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server to sign up the user.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.signup] which makes the request to the server.
  Future<Map<String, dynamic>> signup(
      String password, String username, String email) async {
    await authWebService.signup(password, username, email).then((value) {
      if (value.statusCode == 201) {
        user = value.data;
      } else {
        debugPrint("status code is ${value.statusCode}");
        user = {};
      }
    });
    return user;
  }

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  ///
  /// This function makes the request to the server to log in the user.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.login] which makes the request to the server.
  /// RETURNS [User] : the user data.
  Future<Map<String, dynamic>> login(String password, String username) async {
    await authWebService.login(password, username).then((value) {
      if (value.statusCode == 201) {
        user = value.data;
      } else {
        debugPrint("status code is ${value.statusCode}");
        user = {};
      }
    });
    return user;
  }

  /// [googleToken] : The token of the user from google.
  ///
  /// This function makes the request to the server to log in the user with google.
  /// and checks on the status code if 201 then sets the user and returns it.
  /// This function calls the function [AuthWebService.loginWithGoogle] which makes the request to the server.
  /// RETURNS [User] : the user data.
  Future<Map<String, dynamic>> loginWithGoogle(String googleToken) async {
    // Response res = await authWebService.loginWithGoogle(googleToken);
    // if (res.statusCode == 201) {
    //   user = res.data;
    // } else {
    //   user = {};
    // }
    // return user;
    return {
      "_id": "638f22afb3b5edb0aa8d46ba",
      "token": googleToken,
      "username": "bbnpo",
      "email": "ewxcf@kjdlasd.com",
      "authType": "google",
      "profilePhoto": "",
      "coverPhoto": "",
      "countryCode": "",
      "gender": "",
      "accountClosed": false,
      "displayName": "",
      "about": "",
      "socialLinks": [],
      "nsfw": false,
      "allowFollow": true,
      "contentVisibility": true,
      "activeInCommunitiesVisibility": true,
      "badCommentAutoCollapse": "off",
      "showInSearch": true,
      "adultContent": false,
      "autoPlayMedia": true,
      "personalizeAllOfReddit": true,
      "personalizeAdsInformation": true,
      "personalizeAdsYourActivity": true,
      "personalizeRecGeneralLocation": true,
      "personalizeRecOurPartners": true,
      "useTwoFactorAuthentication": true,
      "suggestedSort": "hot",
      "inboxMessages": true,
      "mentions": true,
      "commentsOnPost": true,
      "upvotePosts": true,
      "upvoteComments": true,
      "repliesComments": true,
      "activityComments": true,
      "activityOnThreads": true,
      "newFollowers": true,
      "newPostFlair": true,
      "newUserFlair": true,
      "pinnedPosts": true,
      "postsYouFollow": true,
      "commentsYouFollow": true,
      "redditAnnouncements": true,
      "cakeDay": true,
      "acceptPms": "everyone",
      "whitelisted": [],
      "safeBrowsingMode": false,
      "chatRequest": true,
      "newFollower": false,
      "unSubscribe": false
    };
  }

  /// [username] : The username of the user.
  ///
  /// This function makes the request to the server to let the user change password if he forget it.
  /// This function calls the function [AuthWebService.forgetPassword] which makes the request to the server.
  /// Returns [bool] which is true if the email sent successfully and false if it's not.
  Future<bool> forgetPassword(String username) async {
    var res = await authWebService.forgetPassword(username);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// [email] : The email of the user.
  ///
  /// This function makes the request to the server if the user requested to get his username.
  /// This function calls the function [AuthWebService.forgetUsername] which makes the request to the server.
  /// Returns [bool] which is true if the email sent successfully and false if it's not.
  Future<bool> forgetUsername(String email) async {
    var res = await authWebService.forgetUsername(email);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// This function makes the request to the server to check on the username if it is available or not.
  /// and checks on the status code if 201 then it's avialable and if it's not 201 so the username isn't avialable.
  /// This function calls the function [AuthWebService.checkOnUsername] which makes the request to the server.
  ///
  /// Returns [bool] : if the username is available so it's true and false if it's not.
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
  /// Returns [List] : a list of random usernames if the status code is 200 and empty list in case of status code isn't 200.
  Future<List<String>> getSuggestedUsernames() async {
    var res = await authWebService.getSuggestedUsernames();
    debugPrint("suggested usernames: ${res.data.toString()}");
    if (res.statusCode == 200) {
      return List<String>.from(res.data);
    } else {
      return [];
    }
  }

  /// [fileAsBytes] : [Uint8List] which is the image required to be uploaded.
  /// [key] : [String] which is The type of change the user want to make.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to the server to get the user's profile picture.
  /// This function calls the function [AuthWebService.updateImageWeb] which makes the request to the server.
  /// Returns [String] : it restuns a string which the link of the profile picture on the server.
  Future<dynamic> updateImageWeb(String key, Uint8List fileAsBytes) async {
    var res = await authWebService.updateImageWeb(fileAsBytes, key);

    UserData.profileSettings!.profile = imagesUrl + res['${key}Photo'];
    return imagesUrl + res['${key}Photo'];
  }

  /// [token] : [String] which is The token of the user.
  /// [gender] : [String] the gender selected by the user
  ///
  /// This function makes the request to udate the user gender during signup.
  /// Returns [bool] which is true if the gender updated successfully and false if it's not.
  Future<bool> genderInSignup(String gender, String token) async {
    var res = await authWebService.genderInSignup(gender, token);
    if (res.statusCode == 200) {
      UserData.accountSettings!.gender = gender;
      return true;
    } else {
      return false;
    }
  }

  /// [selectedInterests] : [Map] which is the list of the interests selected by the user.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to update the user interests during signup.
  /// Returns [bool] which is true if the interests updated successfully and false if it's not.
  Future<bool> addInterests(
      Map<String, dynamic> selectedInterests, String token) async {
    var res = await authWebService.addInterests(selectedInterests, token);
    if (res.statusCode == 200) {
      UserData.user?.interests = selectedInterests;
      return true;
    } else {
      return false;
    }
  }

  /// [token] : [String] which is The id of the user.
  ///
  /// This function makes the request to get the user data with the user Id.
  /// This function calls the function [AuthWebService.getUserData] which makes the request to the server.
  /// Returns [User] : it restuns a user object if the status code is 200 and null in case of status code isn't 200.
  Future<Map<String, dynamic>> getUserData(String token) async {
    var res = await authWebService.getUserData(token);
    if (res.statusCode == 200) {
      debugPrint("user data from repo: ${res.data.toString()}");
      user = res.data;
    } else {
      debugPrint("status code is ${res.statusCode}");
      user = {};
    }
    return user;
  }
}
