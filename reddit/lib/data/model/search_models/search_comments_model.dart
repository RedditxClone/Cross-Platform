import 'package:reddit/data/model/search_models/search_communities_model.dart';
import 'package:reddit/data/model/search_models/search_post_model.dart';

import '../auth_model.dart';

class SearchCommentsModel {
  String? _id;
  String? text;
  int? upvotes;
  DateTime? creationDate;
  User? user;
  SearchComminityModel? subreddit;
  SearchPostModel? post;
  Duration? durantion;

  SearchCommentsModel.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    text = json['text'];
    upvotes = json['upvotes'];
    creationDate = DateTime.parse(json['createdDate']);
    user = User.fromJson(json['user']);
    subreddit = SearchComminityModel.fromJson(json['subreddit']);
    post = SearchPostModel.fromJson(json['post']);
    durantion = DateTime.now().difference(creationDate ?? DateTime.now());
  }
}
