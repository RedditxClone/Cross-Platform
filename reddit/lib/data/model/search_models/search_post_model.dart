import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/search_models/search_communities_model.dart';

import '../auth_model.dart';

class SearchPostModel {
  String? _id;
  String? title;
  int? commentsCount;
  int? votesCount;
  SearchComminityModel? subreddit;
  User? user;
  List<String>? images;
  DateTime? creationDate;
  DateTime? publishDate;
  Duration? durantion;
  String? postedFrom;
  bool? nsfw;
  bool? spoiler;
  SearchPostModel.fromJson(Map<String, dynamic> json) {
    _id = json['_id'] ?? "";
    debugPrint("postID $_id");
    title = json['title'] ?? "";
    debugPrint("postTitle $title");
    commentsCount = json['commentCount'] ?? 0;
    debugPrint("postCommentsCount $commentsCount");
    votesCount = json['votesCount'] ?? 0;
    debugPrint("postVotesCount $votesCount");
    user = User.fromJson(json['user'] ?? {});
    debugPrint("postUser ${user!.username}");
    subreddit = SearchComminityModel.fromJson(json['subreddit'] ?? {});
    debugPrint("postSubreddit ${subreddit!.name}");
    images = List<String>.from(json['images'] ?? []);
    debugPrint("postImages $images");
    creationDate =
        DateTime.parse(json['createdDate'] ?? DateTime.now().toString());
    publishDate =
        DateTime.parse(json['publishedDate'] ?? DateTime.now().toString());
    durantion = DateTime.now()
        .difference(publishDate ?? creationDate ?? DateTime.now());
    if (durantion!.inDays > 0) {
      postedFrom = "${durantion!.inDays} days";
    } else if (durantion!.inHours > 0) {
      postedFrom = "${durantion!.inHours} hours";
    } else if (durantion!.inMinutes > 0) {
      postedFrom = "${durantion!.inMinutes} minutes";
    } else {
      postedFrom = "${durantion!.inSeconds} seconds";
    }
    nsfw = json['nsfw'] ?? false;
    spoiler = json['spoiler'] ?? false;
    debugPrint("postID $_id");
  }
}
