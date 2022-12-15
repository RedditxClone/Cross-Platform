import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/vote_model.dart';
import 'package:reddit/data/repository/posts/vote_repository.dart';

part 'vote_state.dart';

class VoteCubit extends Cubit<VoteState> {
  final VoteRepository voteRepository;

  VoteModel? votes;
  VoteCubit(this.voteRepository) : super(VoteInitial());

  /// This function emits:
  /// state [UpVoted] when the post / comment is upvoted successfully.
  /// This function calls the function [voteRepository.upVote].
  void upVote(String id) {
    // To avoid state error when you leave the page
    debugPrint("Calling from vote cubit before close");
    if (isClosed) return;
    debugPrint("Calling from vote cubit");
    voteRepository.upVote(id).then((votes) {
      emit(UpVoted(votes));
      this.votes = votes;
    });
  }

  /// This function emits:
  /// state [DownVoted] when the post / comment is downVoted successfully.
  /// This function calls the function [voteRepository.downVote].
  void downVote(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    voteRepository.downVote(id).then((votes) {
      emit(DownVoted(votes));
      this.votes = votes;
    });
  }

  /// This function emits:
  /// state [UnVoted] when the post / comment is unVoted successfully.
  /// This function calls the function [voteRepository.unVote].
  void unVote(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    voteRepository.unVote(id).then((votes) {
      emit(UnVoted(votes));
      this.votes = votes;
    });
  }
}
