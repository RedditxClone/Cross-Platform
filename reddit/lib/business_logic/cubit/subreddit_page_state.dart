part of 'subreddit_page_cubit.dart';

@immutable
abstract class SubredditPageState {}

class SubredditPageInitial extends SubredditPageState {}

class SubredditPageLoading extends SubredditPageState {}

class SubredditPageLoaded extends SubredditPageState {
  final SubredditModel subredditModel;
  SubredditPageLoaded(this.subredditModel) {
    "print in state constructor!!";
  }
}

class PostsInPageLoading extends SubredditPageState {}

class InSubreddit extends SubredditPageState {}

class OutSubreddit extends SubredditPageState {}

class Moderator extends SubredditPageState {}

class NotModerator extends SubredditPageState {}

class JoinedSubreddit extends SubredditPageState {}

class FailedToJoin extends SubredditPageState {}

class LeftSubreddit extends SubredditPageState {}

class FailedToLeave extends SubredditPageState {}

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
