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
    print(data);
    final bool ifCreated = await postWebServices.submitPost(data);
    return ifCreated;
  }

  /// `Returns` [List] of the user joined subreddits.
  ///
  /// If there are no subreddits it returns empty list.
  Future<List<SubredditModel>> getUserJoinedSubreddits() async {
    final joinedSubreddits = await postWebServices.getUserJoinedSubreddits();
    debugPrint("newVal: " + joinedSubreddits.toString());
    List<SubredditModel> subreddits = [];
    for (var subreddit in joinedSubreddits) {
      subreddits.add(SubredditModel.fromJson(subreddit));
      debugPrint("subreddits:" + subreddits.toString());
    }
    final modSubreddits = await postWebServices.getUserModSubreddits();
    for (var subreddit in modSubreddits) {
      subreddits.add(SubredditModel.fromJson(subreddit));
      debugPrint("subreddits:" + subreddits.toString());
    }

    return subreddits;
  }
}
