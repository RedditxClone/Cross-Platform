part of 'post_subreddit_preview_cubit.dart';

@immutable
abstract class PostSubredditPreviewState {}

class PostSubredditPreviewCubitInitial extends PostSubredditPreviewState {}

class CreatePostPressed extends PostSubredditPreviewState {}

class UIChanged extends PostSubredditPreviewState {}

class CreatePostFailedToCreate extends PostSubredditPreviewState {}

class CreatePostCreated extends PostSubredditPreviewState {}
