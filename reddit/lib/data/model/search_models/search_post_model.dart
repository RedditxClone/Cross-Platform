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
  bool? nsfw;
  bool? spoiler;
  SearchPostModel.fromJson(Map<String, dynamic> json) {
    _id = json['_id'] ?? "";
    title = json['title'] ?? "";
    commentsCount = json['commentCount'] ?? 0;
    votesCount = json['votesCount'] ?? 0;
    user = User.fromJson(json['user']);
    subreddit = SearchComminityModel.fromJson(json['subreddit'] ?? {});
    images = List<String>.from(json['images'] ?? []);
    creationDate =
        DateTime.parse(json['createdDate'] ?? DateTime.now().toString());
    publishDate =
        DateTime.parse(json['publishedDate'] ?? DateTime.now().toString());
    durantion = DateTime.now()
        .difference(publishDate ?? creationDate ?? DateTime.now());
    nsfw = json['nsfw'] ?? false;
    spoiler = json['spoiler'] ?? false;
    debugPrint("postID $_id");
  }
}
