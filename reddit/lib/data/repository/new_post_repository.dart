import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';
import 'package:reddit/data/web_services/create_post_web_services.dart';

class CreatePostRepository {
  final CreatePostWebServices postWebServices;

  CreatePostRepository(this.postWebServices);

  /// [newpostData] : a [PostModel] that contains all data of the post to be created.
  /// `Returns` `true` if post submitted successfully or `false` if an error occured.
  ///
  /// This function makes the request to the server to create new post.
  ///  It calls the function [CreatePostWebServices.createPost] which makes the request to the server.

  Future<bool> submitPost(PostModel newpostData) async {
    debugPrint("in repo");
    Map<String, dynamic> data = newpostData.toJson();
    debugPrint("before call web services");
    debugPrint(data.toString());
    final bool ifCreated = await postWebServices.submitPost(data);
    return ifCreated;
  }
    Future<dynamic> submitPostWeb(PostModel newpostData) async {
    debugPrint("in repo");
    Map<String, dynamic> data = newpostData.toJson();
    debugPrint("before call web services");
    debugPrint(data.toString());
    final response = await postWebServices.submitPostWeb(data);
    return response;
  }


  /// `Returns` [List] of the user joined subreddits.
  ///
  /// If there are no subreddits it returns empty list.
  Future<List<SubredditModel>> getUserJoinedSubreddits() async {
    final joinedSubreddits = await postWebServices.getUserJoinedSubreddits();
    debugPrint("newVal: $joinedSubreddits");
    List<SubredditModel> subreddits = [];
    for (var subreddit in joinedSubreddits) {
      subreddits.add(SubredditModel.fromJson(subreddit));
      debugPrint("subreddits:$subreddits");
    }
    final modSubreddits = await postWebServices.getUserModSubreddits();
    for (var subreddit in modSubreddits) {
      subreddits.add(SubredditModel.fromJson(subreddit));
      debugPrint("subreddits:$subreddits");
    }

    return subreddits;
  }

  /// [postModel] : a [PostModel] that identifies the post contains that media.
  /// [media] : a [Uint8List] that represents media to be posted.
  /// `Returns` `true` if media uploaded successfully or `false` if an error occured.
  ///
  /// This function makes the request to the server to create new post.
  ///  It calls the function [CreatePostWebServices.postImageAndVideo] which makes the request to the server.

    Future<dynamic> postImageAndVideo(
      String postId, Uint8List media) async {
    final response = await postWebServices.postImageAndVideo(
        postId, media);
    return response;
  }

}
