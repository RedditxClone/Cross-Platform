import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/utils/shared_keys.dart';
import '../../helper/utils/shared_pref.dart';

class User {
  late String? type;
  late String userId;
  late String?
      username; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be the username
  late String? email;
  late String?
      profilePic; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be null
  late String token;
  late String? gender; //could be null if the user didn't choose
  late Map<String, dynamic> interests;
  late String displayName;
  late String about;
  late bool cakeDay;
  User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.profilePic});
  User.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    username = json['username'];
    email = json['email'];
    profilePic = json['profilePhoto'];
    if (UserData.isLogged()) {
      token = PreferenceUtils.getString(SharedPrefKeys.token);
    } else {
      token = json['token'];
    }
    type = json['authType'];
    gender = json['gender'];
    displayName = json['displayName'];
    about = json['about'];
    cakeDay = json['cakeDay'];
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profilePhoto': profilePic,
      'token': token,
      'authType': type,
      '_id': userId,
      'gender': gender,
      'displayName': displayName,
      'about': about,
      'cakeDay': cakeDay,
    };
  }
}

class UserData {
  static User? user;
  static bool isLoggedIn = false;

  ///This function is used to set the user data after the user has signed up or signed in
  ///It should be called only once
  static initUser(Map<String, dynamic> json) {
    UserData.user = User.fromJson(json);
    UserData.isLoggedIn = true;
    PreferenceUtils.setString(SharedPrefKeys.token, UserData.user!.token);
    PreferenceUtils.setString(SharedPrefKeys.userId, UserData.user!.userId);
  }

  static bool isLogged() {
    var userToken = PreferenceUtils.getString(SharedPrefKeys.token);
    debugPrint('token sharedpref is $userToken');
    return userToken
        .isNotEmpty; //if the token not empty so the user is logged in
  }

  static logout() {
    PreferenceUtils.setString(SharedPrefKeys.token, '');
    PreferenceUtils.setString(SharedPrefKeys.userId, '');
    UserData.user = null;
    UserData.isLoggedIn = false;
    debugPrint('user logged out user is ${PreferenceUtils.getString(SharedPrefKeys.token)}');
  }
}
