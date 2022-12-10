import 'package:flutter/material.dart';
import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/model/user_settings.dart';
import '../../helper/utils/shared_keys.dart';
import '../../helper/utils/shared_pref.dart';
import '../web_services/authorization/login_conroller.dart';
import 'account_settings_model.dart';
import 'email_settings.dart';
import 'feed_setting_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class User {
  late String type;
  late String userId;
  late String
      username; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be the username
  late String email;
  // late String?
  //     profilePic; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be null
  late String token;
  // late String? gender; //could be null if the user didn't choose
  late Map<String, dynamic> interests;
  late bool cakeDay;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    username = json['username'];
    email = json['email'];
    // profilePic = json['profilePhoto'];
    if (UserData.isLogged()) {
      token = PreferenceUtils.getString(SharedPrefKeys.token);
    } else {
      token = json['token'];
    }
    type = json['authType'];
    // gender = json['gender'];
    // displayName = json['displayName'];
    // about = json['about'];
    cakeDay = json['cakeDay'];
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      // 'profilePhoto': profilePic,
      'token': token,
      'authType': type,
      '_id': userId,
      // 'gender': gender,
      // 'displayName': displayName,
      // 'about': about,
      'cakeDay': cakeDay,
    };
  }
}

class UserData {
  static User? user;
  static bool isLoggedIn = false;
  static SafetySettings? safetySettings;
  static ProfileSettings? profileSettings;
  static EmailSettings? emailSettings;
  static FeedSettingModel? feedSettings;
  static AccountSettingsModel? accountSettings;

  ///This function is used to set the user data after the user has signed up or signed in
  ///It should be called only once
  static initUser(Map<String, dynamic> json) {
    UserData.user = User.fromJson(json);
    UserData.safetySettings = SafetySettings.fromjson(json);
    UserData.profileSettings = ProfileSettings.fromjson(json);
    UserData.emailSettings = EmailSettings.fromJson(json);
    UserData.feedSettings = FeedSettingModel.fromJson(json);
    UserData.accountSettings = AccountSettingsModel.fromJson(json);
    UserData.isLoggedIn = true;
    PreferenceUtils.setString(SharedPrefKeys.token, UserData.user!.token);
    PreferenceUtils.setString(SharedPrefKeys.userId, UserData.user!.userId);
  }

  static bool isLogged() {
    var userToken = PreferenceUtils.getString(SharedPrefKeys.token);
    debugPrint('token sharedpref is $userToken');
    return userToken != '';
  }

  static logout() {
    if (UserData.user!.type == 'google') {
      if (kIsWeb) {
        GoogleSingInApi.logoutWeb();
      } else {
        GoogleSingInApi.logoutMob();
      }
    }
    PreferenceUtils.setString(SharedPrefKeys.token, '');
    PreferenceUtils.setString(SharedPrefKeys.userId, '');
    UserData.user = null;
    UserData.safetySettings = null;
    UserData.profileSettings = null;
    UserData.emailSettings = null;
    UserData.feedSettings = null;
    UserData.accountSettings = null;
    UserData.isLoggedIn = false;
    debugPrint(
        'user logged out user is ${PreferenceUtils.getString(SharedPrefKeys.token)}');
  }
}
