part of 'post_subreddit_preview_cubit.dart';

@immutable
abstract class PostSubredditPreviewState {}

class PostSubredditPreviewCubitInitial extends PostSubredditPreviewState {}

class CreatePostPressed extends PostSubredditPreviewState {}

class UIChanged extends PostSubredditPreviewState {}

class CreatePostFailedToCreate extends PostSubredditPreviewState {}

class createdInWeb extends PostSubredditPreviewState {
  final postId;

  createdInWeb(this.postId);
}

class errorInCreationWeb extends PostSubredditPreviewState {

  errorInCreationWeb();
}

class CreatePostCreated extends PostSubredditPreviewState {}
