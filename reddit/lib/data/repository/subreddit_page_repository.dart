import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';

import '../web_services/subreddit_page_web_services.dart';

class SubredditPageRepository {
  final SubredditWebServices subredditWebServices;

  SubredditPageRepository(this.subredditWebServices);

  Future<List<PostModel>> getPostsInPage(String subreddit, String mode) async {
    final String postsInPage =
        await subredditWebServices.getPostsInPage(subreddit, mode);

    return List<PostModel>.from(
        jsonDecode(postsInPage).map((i) => PostModel.fromJson(i)));
  }

  Future<SubredditModel> getSubredditInfo(String subredditID) async {
    return SubredditModel.fromJson(
        jsonDecode(await subredditWebServices.getSubredditInfo(subredditID)));
  }

  Future<String> getSubredditIcon(String subreddit) async {
    final String subredditIcon = jsonDecode(
        await subredditWebServices.getSubredditIcon(subreddit))['icon'];
    return subredditIcon;
  }

  Future<bool> updateSubredditIcon(String subredditID, Uint8List updatedIcon) async {
    final bool updated = await subredditWebServices.updateSubredditIcon(
        subredditID, updatedIcon);
    return updated;
  }

  getSubredditDescription(String subredditID) async {
    final String subredditDescription;
    final Map<String, dynamic> json = (jsonDecode(
        await subredditWebServices.getSubredditDescription(subredditID)));

    subredditDescription = json['description'].toString();
    print(subredditDescription);
    return subredditDescription;
  }

  getSubredditModerators(String subreddit) async {
    final List<String> subredditModerators;
    final Map<String, dynamic> json = (jsonDecode(
        await subredditWebServices.getSubredditModerators(subreddit)));

    subredditModerators = List.from(json['moderators']);
    print(subredditModerators);
    return subredditModerators;
  }
}
