part of 'create_post_cubit.dart';

@immutable
abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostCreateBloc extends CreatePostState {
  CreatePostCreateBloc();
}

class CreatePostPressed extends CreatePostState {}

class CreatePostCreated extends CreatePostState {}
class UIChanged extends CreatePostState {}
class NextButtonPressed extends CreatePostState {}
class PostButtonPressed extends CreatePostState{
}

class CreatePostFailedToCreate extends CreatePostState {}

// class UserJoinedSubredditsUploaded extends CreatePostState {
//   final List<SubredditModel> userJoinedSubreddits;

//   UserJoinedSubredditsUploaded(this.userJoinedSubreddits);
  
// }
