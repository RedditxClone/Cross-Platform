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
    _id = json['_id'];
    title = json['title'];
    commentsCount = json['commentCount'];
    votesCount = json['votesCount'];
    subreddit = json['subreddit'];
    user = User.fromJson(json['user']);
    subreddit = SearchComminityModel.fromJson(json['subreddit']);
    images = List<String>.from(json['images']);
    creationDate = DateTime.parse(json['createdDate']);
    publishDate = DateTime.parse(json['publishedDate']);
    durantion = DateTime.now()
        .difference(publishDate ?? creationDate ?? DateTime.now());
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
  }
}
