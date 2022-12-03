import 'dart:convert';

import 'package:reddit/data/model/change_password_model.dart';

import '../../model/left_drawer/left_drawer_model.dart';
import '../../web_services/left_drawer/left_drawer_web_services.dart';

class LeftDrawerRepository {
  final LeftDrawerWebServices leftDrawerWebServices;

  LeftDrawerRepository(this.leftDrawerWebServices);

  /// Returns [List] of [LeftDrawerModel] object that contains the communities you are currently moderating
  /// after getting it from [LeftDrawerWebServices] and mapping it to the model list.
  Future<List<LeftDrawerModel>> getModeratingCommunities() async {
    final moderatingCommunities =
        await leftDrawerWebServices.getModeratingCommunities();
    print("Moderating Communities from repo:");
    print("$moderatingCommunities");
    return List<LeftDrawerModel>.from(jsonDecode(moderatingCommunities)
        .map((i) => LeftDrawerModel.fromJson(i)));
  }

  /// Returns [List] of [LeftDrawerModel] object that contains the communities you are currently joined in
  /// after getting it from [LeftDrawerWebServices] and mapping it to the model list.
  Future<List<LeftDrawerModel>> getYourCommunities() async {
    final yourCommunities = await leftDrawerWebServices.getYourCommunities();
    print("Your Communities from repo:");
    print("$yourCommunities");
    return List<LeftDrawerModel>.from(
        jsonDecode(yourCommunities).map((i) => LeftDrawerModel.fromJson(i)));
  }

  /// Returns [List] of [LeftDrawerModel] object that contains the users you are currently following
  /// after getting it from [LeftDrawerWebServices] and mapping it to the model list.
  Future<List<LeftDrawerModel>> getFollowingUsers() async {
    final following = await leftDrawerWebServices.getFollowingUsers();
    print("Following from repo:");
    print("$following");
    return List<LeftDrawerModel>.from(
        jsonDecode(following).map((i) => LeftDrawerModel.fromJson(i)));
  }
}
