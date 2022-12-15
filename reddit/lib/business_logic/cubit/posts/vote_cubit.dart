import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/posts/vote_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';

part 'vote_state.dart';

class VoteCubit extends Cubit<VoteState> {
  final PostActionsRepository postActionsRepository;
  VoteModel? votes;
  VoteCubit(this.postActionsRepository) : super(VoteInitial());

  /// This function emits:
  /// state [UpVoted] when the post / comment is upvoted successfully.
  /// This function calls the function [PostActionsRepository.upVote].
  void upVote(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(VoteError(403));
    } else {
      postActionsRepository.upVote(id).then((votes) {
        emit(UpVoted(votes));
        this.votes = votes;
      });
    }
  }

  /// This function emits:
  /// state [DownVoted] when the post / comment is downVoted successfully.
  /// This function calls the function [PostActionsRepository.downVote].
  void downVote(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(VoteError(403));
    } else {
      postActionsRepository.downVote(id).then((votes) {
        emit(DownVoted(votes));
        this.votes = votes;
      });
    }
  }

  /// This function emits:
  /// state [UnVoted] when the post / comment is unVoted successfully.
  /// This function calls the function [PostActionsRepository.unVote].
  void unVote(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(VoteError(403));
    } else {
      postActionsRepository.unVote(id).then((votes) {
        emit(UnVoted(votes));
        this.votes = votes;
      });
    }
  }
}
