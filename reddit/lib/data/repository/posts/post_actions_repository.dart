import 'package:reddit/data/model/posts/vote_model.dart';
import 'package:reddit/data/web_services/posts/post_actions_web_services.dart';

class PostActionsRepository {
  final PostActionsWebServices postActionsWebServices;
  PostActionsRepository(this.postActionsWebServices);

  /// [id] id of the post to be saved
  /// Returns Status Code of the response
  Future<int> savePost(String id) async {
    final statusCode = await postActionsWebServices.savePost(id);
    return statusCode;
  }

  /// [id] id of the post to be unsaved
  /// Returns Status Code of the response
  Future<int> unsavePost(String id) async {
    final statusCode = await postActionsWebServices.unsavePost(id);
    return statusCode;
  }

  /// [id] id of the post to be hidden
  /// Returns Status Code of the response
  Future<int> hidePost(String id) async {
    final statusCode = await postActionsWebServices.hidePost(id);
    return statusCode;
  }

  /// [id] id of the post to be deleted
  /// Returns Status Code of the response
  Future<int> deletePost(String id) async {
    final statusCode = await postActionsWebServices.deletePost(id);
    return statusCode;
  }

  /// [id] id of the post to be unhidden
  /// Returns Status Code of the response
  Future<int> unhidePost(String id) async {
    final statusCode = await postActionsWebServices.unhidePost(id);
    return statusCode;
  }

  /// [id] id of the post to be spammed
  /// Returns Status Code of the response
  Future<int> spamPost(String id) async {
    final statusCode = await postActionsWebServices.spamPost(id);
    return statusCode;
  }

  /// [id] id of the post/comment to be upvoted
  /// Returns [VoteModel] object that contains the new votes number
  /// after getting it from [PostActionsWebServices.upVote] and mapping it to the model list.
  Future<VoteModel> upVote(String id) async {
    final votes = await postActionsWebServices.upVote(id);
    // debugPrint("Up vote from repo:");
    // debugPrint("$votes");
    return VoteModel.fromJson(votes);
  }

  /// [id] id of the post/comment to be downvoted
  /// Returns [VoteModel] object that contains the new votes number
  /// after getting it from [PostActionsWebServices.downVote] and mapping it to the model list.
  Future<VoteModel> downVote(String id) async {
    final votes = await postActionsWebServices.downVote(id);
    // debugPrint("Down vote from repo:");
    // debugPrint("$votes");
    return VoteModel.fromJson(votes);
  }

  /// [id] id of the post/comment to be unvoted
  /// Returns [VoteModel] object that contains the new votes number
  /// after getting it from [PostActionsWebServices.unVote] and mapping it to the model list.
  Future<VoteModel> unVote(String id) async {
    final votes = await postActionsWebServices.unVote(id);
    // debugPrint("Unvote from repo:");
    // debugPrint("$votes");
    return VoteModel.fromJson(votes);
  }
}
