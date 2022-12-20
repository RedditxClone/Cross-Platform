import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';

class ModToolsRepository {
  final ModToolsWebServices webServices;
  ModToolsRepository(this.webServices);

  /// [subredditId] is the id of subreddit to get the edited posts
  /// [subredditName] is the name of subreddit to get the edited posts
  /// Returns [List] of [PostsModel] object that contains the list of edited posts
  /// after getting it from [ModToolsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getEditedPosts(
      String subredditId, String subredditName) async {
    final posts = await webServices.getEditedPosts(subredditId);
    return List<PostsModel>.from(posts.map((i) {
      PostsModel temp = PostsModel.fromJson(i);
      temp.subreddit!.name = subredditName;
      return temp;
    }));
  }

  /// [subredditId] is the id of subreddit to get the spammed posts
  /// [subredditName] is the name of subreddit to get the spammed posts
  /// Returns [List] of [PostsModel] object that contains the list of spammed posts
  /// after getting it from [ModToolsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getSpammedPosts(
      String subredditId, String subredditName) async {
    final posts = await webServices.getSpammedPosts(subredditId);
    return List<PostsModel>.from(posts.map((i) {
      PostsModel temp = PostsModel.fromJson(i);
      temp.subreddit!.name = subredditName;
      return temp;
    }));
  }

  /// [subredditId] is the id of subreddit to get the unmoderated posts
  /// [subredditName] is the name of subreddit to get the unmoderated posts
  /// Returns [List] of [PostsModel] object that contains the list of unmoderated posts
  /// after getting it from [ModToolsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getUnmoderatedPosts(
      String subredditId, String subredditName) async {
    final posts = await webServices.getUnmoderatedPosts(subredditId);
    return List<PostsModel>.from(posts.map((i) {
      PostsModel temp = PostsModel.fromJson(i);
      temp.subreddit!.name = subredditName;
      return temp;
    }));
  }

  /// [subredditID] is the id of subreddit to which we get the approved list
  /// Returns [List] of the approved users in modtools
  Future<List<dynamic>> getAprroved(String subredditID) async {
    final approvedList = await webServices.getApproved(subredditID);
    return approvedList;
  }

  /// [subredditID] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// Returns status code 201 if insert is successfull
  Future<int> addApprovedUser(String subredditID, String username) async {
    final statusCode = await webServices.addApprovedUser(subredditID, username);
    return statusCode;
  }

  /// [subredditID] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// Returns status code 201 if remove is successfull
  Future<int> removeApprovedUser(String subredditID, String username) async {
    final statusCode =
        await webServices.removeApprovedUser(subredditID, username);
    return statusCode;
  }
}
