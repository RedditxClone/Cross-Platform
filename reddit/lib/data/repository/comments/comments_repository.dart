import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/model/comments/comment_submit.dart';
import 'package:reddit/data/web_services/comments/comments_web_services.dart';

import '../../model/posts/posts_model.dart';
import '../../web_services/posts/posts_web_services.dart';

class CommentsRepository {
  final CommentsWebServices commentsWebServices;

  CommentsRepository(this.commentsWebServices);

  /// [id] of post/comment that we want to get its comments/replies
  /// Returns [List] of [Comments] object that contains the comments of post or comment [id]
  /// after getting it from [CommentsWebServices] and mapping it to the model list.
  Future<List<Comments>> getThingComments(String id) async {
    final comments = await commentsWebServices.getThingComments(id);
    // debugPrint("Post comments from repo:");
    // debugPrint("$comments");
    return List<Comments>.from(comments.map((i) => Comments.fromJson(i)));
  }

  /// [commentSubmit] Model containin the info of the comment that will be added
  /// Map new comment model to Json and send it to web services [CommentsWebServices.addComment].
  /// Returns [Comments] which is the model of the new added comment
  Future<Comments> addComment(CommentSubmit commentSubmit) async {
    Map<String, dynamic> jsonMap = commentSubmit.toJson();
    final comment = await commentsWebServices.addComment(jsonMap);
    return Comments.fromJson(comment);
  }
}
