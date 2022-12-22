import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';

import '../web_services/subreddit_page_web_services.dart';

class SubredditPageRepository {
  final SubredditWebServices subredditWebServices;

  SubredditPageRepository(this.subredditWebServices);

  // Future<List<PostModel>> getPostsInPage(String subreddit, String mode) async {
  //   final postsInPage =
  //       await subredditWebServices.getPostsInPage(subreddit, mode);
  //   final postModelList = <PostModel>[];
  //   for (var post in postsInPage) {
  //     postModelList.add(PostModel.fromJson(post));
  //   }
  //   return postModelList;
  // }

  Future<SubredditModel> getSubredditInfo(String subredditId) async {
    final data = await subredditWebServices.getSubredditInfo(subredditId);
    print("data: " + data.toString());
    if (kIsWeb) {
      SubredditModel subredditModel;

      if (data['error'] != null) {
        subredditModel = SubredditModel(sId: subredditId);
      } else {
        subredditModel = SubredditModel.fromJson((data));
      }
      debugPrint(subredditModel.toString());
      return subredditModel;
    } else {
      return SubredditModel.fromJson((data));
    }
  }

  // Future<String> getSubredditIcon(String subreddit) async {
  //   final String subredditIcon =
  //       (await subredditWebServices.getSubredditIcon(subreddit))['icon'];
  //   return subredditIcon;
  // }

  Future<bool> joinSubreddit(String subredditId) async {
    final bool joined = await subredditWebServices.joinSubreddit(subredditId);
    return joined;
  }

  Future<bool> leaveSubreddit(String subredditId) async {
    final bool left = await subredditWebServices.leaveSubreddit(subredditId);
    return left;
  }

  Future<bool> updateSubredditIcon(
      String subredditName, Uint8List updatedIcon) async {
    final bool updated = await subredditWebServices.updateSubredditIcon(
        subredditName, updatedIcon);
    return updated;
  }

  // getSubredditDescription(String subredditName) async {
  //   final String subredditDescription;
  //   final Map<String, dynamic> json =
  //       ((await subredditWebServices.getSubredditDescription(subredditName)));

  //   subredditDescription = json['description'].toString();
  //   print(subredditDescription);
  //   return subredditDescription;
  // }

  // getSubredditModerators(String subreddit) async {
  //   final List<String> subredditModerators;
  //   final Map<String, dynamic> json =
  //       ((await subredditWebServices.getSubredditModerators(subreddit)));

  //   subredditModerators = List.from(json['moderators']);
  //   print(subredditModerators);
  //   return subredditModerators;
  // }

  Future<bool> getIfJoined(String subredditId) async {
    final bool ifJoined = await subredditWebServices.getIfJoined(subredditId);
    return ifJoined;
  }

  Future<bool> getIfMod(String subredditId) async {
    final bool ifMod = await subredditWebServices.getIfMod(subredditId);
    return ifMod;
  }
}
