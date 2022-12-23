import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
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
  String? type;
  String? userId;
  String?
      username; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be the username
  String? email;
  String?
      profilePic; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be null
  String? token;
  String? displayName;
  Map<String, dynamic>? interests;
  bool? cakeDay;
  String? about;
  bool? allowFollow;
  bool? followed;
  late String coverPhoto;
  late String? createdAt;
  late bool? isFollowed;
  late bool? isBlocked;
  late String date;
  User.fromJson(Map<String, dynamic> json) {
    debugPrint("user id is: ${json['_id']}");
    debugPrint("user username is: ${json['username']}");
    debugPrint("user profilePic is: ${json['profilePhoto']}");
    debugPrint("user cakeDay is: ${json['cakeDay']}");
    debugPrint("user about is: ${json['about']}");
    debugPrint("user allowFollow is: ${json['allowFollow']}");

    userId = json['_id'] ?? "";
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    profilePic = json['profilePhoto'] == null || json['profilePhoto'] == ''
        ? ''
        : imagesUrl + json['profilePhoto'];
    coverPhoto = json['coverPhoto'] == null || json['coverPhoto'] == ''
        ? ''
        : imagesUrl + json['coverPhoto'];
    if (UserData.isLogged()) {
      token = PreferenceUtils.getString(SharedPrefKeys.token);
    } else {
      token = json['token'] ?? "";
    }
    type = json['authType'] ?? "";
    // gender = json['gender'];
    displayName = json['displayName'] ?? "";
    date = json['date'] ?? "";
    about = json['about'] ?? "";
    cakeDay = json['cakeDay'] ?? true;
    allowFollow = json['allowFollow'] ?? true;
    followed = json['followed'] ?? false;
    isFollowed = json['isFollowed'] ?? false;
    isBlocked = json['isBlocked'] ?? false;
    createdAt = json['createdAt'] ?? "";
    debugPrint("finish with user");
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profilePhoto': profilePic,
      'token': token,
      'authType': type,
      '_id': userId,
      // 'gender': gender,
      'displayName': displayName,
      'about': about,
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
    PreferenceUtils.setString(SharedPrefKeys.token, UserData.user!.token ?? "");
    PreferenceUtils.setString(
        SharedPrefKeys.userId, UserData.user!.userId ?? "");
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
    } else if (UserData.user!.type == 'github') {
      // GithubAuthenticator.logout();
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
        'user logged out user is and token  =  ${PreferenceUtils.getString(SharedPrefKeys.token)}');
  }
}
