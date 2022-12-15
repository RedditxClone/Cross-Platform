import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/change_password_model.dart';
import 'package:reddit/data/model/left_drawer/joined_subreddits_drawer_model.dart';

import '../../model/left_drawer/following_users_drawer_model.dart';
import '../../web_services/left_drawer/left_drawer_web_services.dart';

class LeftDrawerRepository {
  final LeftDrawerWebServices leftDrawerWebServices;

  LeftDrawerRepository(this.leftDrawerWebServices);

  /// Returns [List] of [FollowingUsersDrawerModel] object that contains the communities you are currently moderating
  /// after getting it from [LeftDrawerWebServices] and mapping it to the model list.
  Future<List<FollowingUsersDrawerModel>> getModeratingCommunities() async {
    final moderatingCommunities =
        await leftDrawerWebServices.getModeratingCommunities();
    print("Moderating Communities from repo:");
    print("$moderatingCommunities");
    return List<FollowingUsersDrawerModel>.from(
        jsonDecode(moderatingCommunities)
            .map((i) => FollowingUsersDrawerModel.fromJson(i)));
  }

  /// Returns [List] of [JoinedSubredditsDrawerModel] object that contains the communities you are currently joined in
  /// after getting it from [LeftDrawerWebServices] and mapping it to the model list.
  Future<List<JoinedSubredditsDrawerModel>> getYourCommunities() async {
    final yourCommunities = await leftDrawerWebServices.getYourCommunities();
    // debugPrint("Your Communities from repo:");
    // debugPrint("$yourCommunities");
    return List<JoinedSubredditsDrawerModel>.from(
        yourCommunities.map((i) => JoinedSubredditsDrawerModel.fromJson(i)));
  }

  /// Returns [FollowingUsersDrawerModel] object that contains the users you are currently following
  /// after getting it from [LeftDrawerWebServices] and mapping it to the model list.
  Future<FollowingUsersDrawerModel> getFollowingUsers() async {
    final following = await leftDrawerWebServices.getFollowingUsers();
    debugPrint("Following from repo:");
    debugPrint("$following");
    return FollowingUsersDrawerModel.fromJson(following);

    // return List<LeftDrawerModel>.from(
    //     jsonDecode(following).map((i) => LeftDrawerModel.fromJson(i)));
  }
}
