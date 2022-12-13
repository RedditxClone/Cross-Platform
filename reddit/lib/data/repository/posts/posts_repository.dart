import 'package:flutter/cupertino.dart';

import '../../model/posts/posts_model.dart';
import '../../web_services/posts/posts_web_services.dart';

class PostsRepository {
  final PostsWebServices postsDrawerWebServices;

  PostsRepository(this.postsDrawerWebServices);

  /// Returns [List] of [PostsModel] object that contains the communities you are currently joined in
  /// after getting it from [PostsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getTimelinePosts() async {
    final posts = await postsDrawerWebServices.getTimelinePosts();
    debugPrint("posts from repo:");
    debugPrint("$posts");
    return posts == ""
        ? []
        : List<PostsModel>.from(posts.map((i) => PostsModel.fromJson(i)));
  }
}
