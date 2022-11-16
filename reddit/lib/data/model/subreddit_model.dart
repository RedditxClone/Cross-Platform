
import 'package:reddit/data/model/post_model.dart';

class SubredditModel {
  late bool isMod;
  late bool joined;
  late String icon;
  late List<PostModel> posts;
  late String subredditId;
  late DateTime creationDate;
  late String description;
  late List<String> moderators;
  late int membersCount;
  late List<String> flairs;

  SubredditModel.copyPostsFromJson(List<dynamic> jsons) {
    posts = [];
    for (var json in jsons) {
      posts.add(PostModel.fromJson((json)));
    }
  }

  List<Map<String, dynamic>> postsToJson() {
    final List<Map<String, dynamic>> data = [];
    for (PostModel post in posts) {
      data.add(post.toJson());
    }
    return data;
  }

  SubredditModel.fromJson(Map<String, dynamic> json) {
    flairs = (json['flairs']).cast<String>();
    isMod = json['isMod'];
    joined = json['joined'];
    icon = json['icon'];
    SubredditModel.copyPostsFromJson(json['posts']);
    subredditId = json['subredditId'];
    creationDate = DateTime.parse(json['creationDate']);
    description = json['description'];
    moderators = json['moderators'].cast<String>();
    membersCount = json['membersCount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subredditId'] = subredditId;
    data['flairs'] = flairs;
    data['isMod'] = isMod;
    data['joined'] = joined;
    data['icon'] = icon;
    data['posts'] = postsToJson;
    data['creationDate'] = creationDate;
    data['description'] = description;
    data['moderators'] = moderators;
    data['membersCount'] = membersCount;
    return data;
  }
}
