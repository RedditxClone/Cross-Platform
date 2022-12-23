import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/modtools/taffic_stats_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';

import '../../model/auth_model.dart';

class ModToolsRepository {
  final ModToolsWebServices webServices;

  ModToolsRepository(this.webServices);
  late List<TrafficStats> trafficStats;

  /// [subredditName] is the Name of subreddit to get the edited posts
  ///
  /// Returns [List] of [PostsModel] object that contains the list of edited posts
  /// after getting it from [ModToolsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getEditedPosts(String subredditName) async {
    final posts = await webServices.getEditedPosts(subredditName);
    return List<PostsModel>.from(posts.map((i) {
      PostsModel temp = PostsModel.fromJson(i);
      temp.subreddit!.name = subredditName;
      return temp;
    }));
  }

  /// [subredditName] is the Name of subreddit to get the spammed posts.
  ///
  /// Returns [List] of [PostsModel] object that contains the list of spammed posts
  /// after getting it from [ModToolsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getSpammedPosts(String subredditName) async {
    final posts = await webServices.getSpammedPosts(subredditName);
    return List<PostsModel>.from(posts.map((i) {
      PostsModel temp = PostsModel.fromJson(i);
      temp.subreddit!.name = subredditName;
      return temp;
    }));
  }

  /// [subredditName] is the name of subreddit to get the unmoderated posts.
  ///
  /// Returns [List] of [PostsModel] object that contains the list of unmoderated posts.
  /// after getting it from [ModToolsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getUnmoderatedPosts(String subredditName) async {
    final posts = await webServices.getUnmoderatedPosts(subredditName);
    return List<PostsModel>.from(posts.map((i) {
      PostsModel temp = PostsModel.fromJson(i);
      temp.subreddit!.name = subredditName;
      return temp;
    }));
  }

  /// [subredditName] is the Name of subreddit to which we get the traffic stats
  ///
  /// Returns [List] of the approved users in modtools
  Future<List<TrafficStats>> getStatistics(String subredditName) async {
    final statistics = await webServices.getStatistics(subredditName);
    trafficStats = statistics.map((i) => TrafficStats.fromJson(i)).toList();
    return trafficStats;
  }

  /// [subredditId] is the id of subreddit to which we get the approved list
  ///
  /// Returns [List] of the approved users in modtools
  Future<List<dynamic>> getAprroved(String subredditId) async {
    final approvedList = await webServices.getApproved(subredditId);
    return approvedList;
  }

  /// [subredditId] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  ///
  /// Returns status code 201 if insert is successfull
  Future<int> addApprovedUser(String subredditId, String username) async {
    final statusCode = await webServices.addApprovedUser(subredditId, username);
    return statusCode;
  }

  /// [subredditId] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  ///
  /// Returns status code 201 if remove is successfull
  Future<int> removeApprovedUser(String subredditId, String username) async {
    final statusCode =
        await webServices.removeApprovedUser(subredditId, username);
    return statusCode;
  }

  /// [subredditId] is the id of subreddit to which we get the moderators list
  ///
  /// Returns [List] of [User] object that contains the list of moderators
  Future<List<User>> getModerators(String subredditId) async {
    Response res = await webServices.getModerators(subredditId);
    if (res.statusCode == 200) {
      return List<User>.from(res.data.map((i) => User.fromJson(i)));
    } else {
      return [];
    }
  }

  /// [subredditId] is the id of subreddit to which we add a moderator
  /// [username] is the username of the user to be added as a moderator
  ///
  /// This function calls [addModerator] from [ModToolsWebServices] and returns the status code
  /// Returns status code 201 if add is successfull and 400 if the user is already a moderator
  Future<int> addModerator(String subredditId, String username) async {
    Response res = await webServices.addModerator(subredditId, username);
    debugPrint("rsponse code ${res.statusCode}");
    return res.statusCode ?? 0;
  }

  /// [subredditId] is the id of subreddit to add new user to the muted list
  /// [username] is the username of the user to be added to the muted list
  /// [muteReason] is the reason for muting the user
  ///
  /// This function calls [muteUser] from [ModToolsWebServices] and returns the status code
  /// Returns status code 201 if add is successfull and 400 if the user is already muted
  Future<int> muteUser(
      String subredditId, String username, String muteReason) async {
    Response res =
        await webServices.muteUser(subredditId, username, muteReason);
    return res.statusCode ?? 0;
  }

  /// [subredditId] is the id of subreddit to get the muted list
  ///
  /// This function calls [getMutedUsers] from [ModToolsWebServices] and maps the response to [User] model
  /// Returns [List] of [User] object that contains the list of muted users
  Future<List<User>> getMutedUsers(String subredditId) async {
    var res = await webServices.getMutedUsers(subredditId);
    if (res.statusCode == 200) {
      return List<User>.from(res.data.map((i) => User.fromJson(i)));
    } else {
      return [];
    }
  }

  /// [subredditId] is the id of subreddit to get the banned list
  ///
  /// This function calls [getBannedUsers] from [ModToolsWebServices] and maps the response to [User] model
  /// Returns [List] of [User] object that contains the list of banned users
  Future<List<User>> getBannedUsers(String subredditId) async {
    var res = await webServices.getBannedUsers(subredditId);
    if (res.statusCode == 200) {
      return List<User>.from(res.data.map((i) => User.fromJson(i)));
    } else {
      return [];
    }
  }

  /// [subredditId] is the id of subreddit to add new user to the banned list
  /// [username] is the username of the user to be added to the banned list
  /// [banReason] is the reason for banning the user
  /// [banDays] is the duration for which the user is banned
  /// [modNote] is the note for banning the user
  /// [banMessage] is the message to be sent to the user
  /// [permanent] is the boolean value to ban the user permanently
  ///
  /// This function calls [banUser] from [ModToolsWebServices] and returns the status code
  /// Returns status code 201 if add is successfull and 400 if the user is already banned
  Future<int> banUser(String subredditId, String username, String banReason,
      int banDays, String modNote, String banMessage, bool permanent) async {
    Response res = await webServices.banUser(subredditId, username, banReason,
        banDays, modNote, banMessage, permanent);
    return res.statusCode ?? 0;
  }
}
