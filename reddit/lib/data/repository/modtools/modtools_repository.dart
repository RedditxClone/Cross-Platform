import 'package:reddit/data/model/modtools/taffic_stats_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';

class ModToolsRepository {
  final ModToolsWebServices webServices;

  ModToolsRepository(this.webServices);
  late List<TrafficStats> trafficStats;

  /// [subredditName] is the Name of subreddit to get the edited posts
  /// [subredditName] is the name of subreddit to get the edited posts
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

  /// [subredditName] is the Name of subreddit to get the spammed posts
  /// [subredditName] is the name of subreddit to get the spammed posts
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

  /// [subredditName] is the name of subreddit to get the unmoderated posts
  /// Returns [List] of [PostsModel] object that contains the list of unmoderated posts
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
  /// Returns [List] of the approved users in modtools
  Future<List<TrafficStats>> getStatistics(String subredditName) async {
    final statistics = await webServices.getStatistics(subredditName);
    trafficStats = statistics.map((i) => TrafficStats.fromJson(i)).toList();
    return trafficStats;
  }

  /// [subredditId] is the id of subreddit to which we get the approved list
  /// Returns [List] of the approved users in modtools
  Future<List<dynamic>> getAprroved(String subredditId) async {
    final approvedList = await webServices.getApproved(subredditId);
    return approvedList;
  }

  /// [subredditId] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// Returns status code 201 if insert is successfull
  Future<int> addApprovedUser(String subredditId, String username) async {
    final statusCode = await webServices.addApprovedUser(subredditId, username);
    return statusCode;
  }

  /// [subredditId] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// Returns status code 201 if remove is successfull
  Future<int> removeApprovedUser(String subredditId, String username) async {
    final statusCode =
        await webServices.removeApprovedUser(subredditId, username);
    return statusCode;
  }
}
