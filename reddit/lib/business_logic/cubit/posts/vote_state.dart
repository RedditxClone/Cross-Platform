part of 'vote_cubit.dart';

@immutable
abstract class VoteState {}

class VoteInitial extends VoteState {}

class UpVoted extends VoteState {
  VoteModel? votesCount;
  UpVoted(this.votesCount);
}

class DownVoted extends VoteState {
  VoteModel? votesCount;
  DownVoted(this.votesCount);
}

class UnVoted extends VoteState {
  VoteModel? votesCount;
  UnVoted(this.votesCount);
}
