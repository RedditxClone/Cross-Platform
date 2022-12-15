import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/posts/vote_model.dart';
import 'package:reddit/data/web_services/posts/vote_web_services.dart';

import '../../model/posts/posts_model.dart';
import '../../web_services/posts/posts_web_services.dart';

class VoteRepository {
  final VoteWebServices voteWebServices;

  VoteRepository(this.voteWebServices);

  /// Returns [VoteModel] object that contains the new votes number
  /// after getting it from [VoteWebServices.upVote] and mapping it to the model list.
  Future<VoteModel> upVote(String id) async {
    final votes = await voteWebServices.upVote(id);
    debugPrint("Up vote from repo:");
    debugPrint("$votes");
    return VoteModel.fromJson(votes);
  }

  /// Returns [VoteModel] object that contains the new votes number
  /// after getting it from [VoteWebServices.downVote] and mapping it to the model list.
  Future<VoteModel> downVote(String id) async {
    final votes = await voteWebServices.downVote(id);
    debugPrint("Down vote from repo:");
    debugPrint("$votes");
    return VoteModel.fromJson(votes);
  }

  /// Returns [VoteModel] object that contains the new votes number
  /// after getting it from [VoteWebServices.unVote] and mapping it to the model list.
  Future<VoteModel> unVote(String id) async {
    final votes = await voteWebServices.unVote(id);
    debugPrint("Unvote from repo:");
    debugPrint("$votes");
    return VoteModel.fromJson(votes);
  }
}
