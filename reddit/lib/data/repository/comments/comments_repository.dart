import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/web_services/comments/comments_web_services.dart';

import '../../model/posts/posts_model.dart';
import '../../web_services/posts/posts_web_services.dart';

class CommentsRepository {
  final CommentsWebServices commentsWebServices;

  CommentsRepository(this.commentsWebServices);

  /// Returns [List] of [Comments] object that contains the comments of post or comment [id]
  /// after getting it from [CommentsWebServices] and mapping it to the model list.
  Future<List<Comments>> getThingComments(String id) async {
    final comments = await commentsWebServices.getThingComments(id);
    debugPrint("Timeline comments from repo:");
    debugPrint("$comments");
    return List<Comments>.from(comments.map((i) => Comments.fromJson(i)));
  }
}
