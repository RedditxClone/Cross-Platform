import 'package:flutter/material.dart';
import 'package:reddit/data/model/search_models/search_communities_model.dart';
import 'package:reddit/data/model/search_models/search_post_model.dart';

import '../auth_model.dart';

class SearchCommentsModel {
  String? _id;
  String? text;
  int? upvotes;
  DateTime? creationDate;
  User? user;
  User? postOwner;
  SearchComminityModel? subreddit;
  SearchPostModel? post;
  Duration? durantion;
  String? commentFrom;

  SearchCommentsModel.fromJson(Map<String, dynamic> json) {
    _id = json['_id']??'';
    debugPrint("comment id: $_id");
    text = json['text']??'';
    debugPrint("comment text: $text");
    upvotes = json['votesCount']??0;
    debugPrint("comment upvotes: $upvotes");
    user = User.fromJson(json['user'] ?? {});
    debugPrint("comment user: ${user!.username}");
    postOwner = User.fromJson(json['postOwner'] ?? {});
    debugPrint("comment postOwner: ${postOwner!.username}");
    subreddit = SearchComminityModel.fromJson(json['subreddit'] ?? {});
    debugPrint("comment subreddit: ${subreddit!.name}");
    post = SearchPostModel.fromJson(json['post'] ?? {});
    debugPrint("comment post: ${post!.title}");
    creationDate =
        DateTime.parse(json['createdDate'] ?? DateTime.now().toString());
    debugPrint("comment creationDate: $creationDate");
    durantion = DateTime.now().difference(creationDate ?? DateTime.now());
    debugPrint("comment durantion: $durantion");
    if (durantion!.inDays > 0) {
      commentFrom = "${durantion!.inDays} days";
    } else if (durantion!.inHours > 0) {
      commentFrom = "${durantion!.inHours} hours";
    } else if (durantion!.inMinutes > 0) {
      commentFrom = "${durantion!.inMinutes} minutes";
    } else {
      commentFrom = "${durantion!.inSeconds} seconds";
    }
  }
}
