part of 'post_to_cubit.dart';

@immutable
abstract class PostToState {}

class PostToCubitInitial extends PostToState {}

class UIChanged extends PostToState {}

class UserJoinedSubredditsUploaded extends PostToState {
  final userJoinedSubreddits;

  UserJoinedSubredditsUploaded(this.userJoinedSubreddits);
}

class UserJoinedSubredditsUploading extends PostToState {}
