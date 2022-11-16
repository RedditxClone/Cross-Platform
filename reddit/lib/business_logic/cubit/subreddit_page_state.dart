part of 'subreddit_page_cubit.dart';

@immutable
abstract class SubredditPageState {}

class SubredditPageInitial extends SubredditPageState {}

class SubredditPageLoading extends SubredditPageState {}

class SubredditPageLoaded extends SubredditPageState {
  final SubredditModel subredditModel;
  SubredditPageLoaded(this.subredditModel);
}

class PostsInPageLoading extends SubredditPageState {}

class SubredditDescriptionLoaded extends SubredditPageState {
  final String subredditDescription;
  SubredditDescriptionLoaded(this.subredditDescription);
}

class SubredditModeratorsLoaded extends SubredditPageState {
  final List<String> subredditModerators;
  SubredditModeratorsLoaded(this.subredditModerators);
}

class SubredditModeratorsLoading extends SubredditPageState {}

class SubredditIconUpdating extends SubredditPageState {}
class SubredditIconUpdateFailed extends SubredditPageState {}
class SubredditIconLoaded extends SubredditPageState {
  final String subredditIcon;
  SubredditIconLoaded(this.subredditIcon);
}

class ToggleSwitch extends SubredditPageState {}

class PostsInPageLoaded extends SubredditPageState {
  final List<PostModel> postsInPageModels;
  PostsInPageLoaded(this.postsInPageModels);
}
