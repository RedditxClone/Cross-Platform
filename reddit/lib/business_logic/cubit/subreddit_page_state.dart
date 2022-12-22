part of 'subreddit_page_cubit.dart';

@immutable
abstract class SubredditPageState {}

class SubredditPageInitial extends SubredditPageState {}

class SubredditPageLoading extends SubredditPageState {}

class SubredditPageLoaded extends SubredditPageState {
  final SubredditModel subredditModel;
  final bool isMod;
  final bool isJoined;
  SubredditPageLoaded(this.subredditModel, this.isMod, this.isJoined) {
    debugPrint("in state" + subredditModel.toString());
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

class SubredditIconUpdated extends SubredditPageState {
  final String subredditIcon;
  SubredditIconUpdated(this.subredditIcon);
}

class ToggleSwitch extends SubredditPageState {}

class PostsInPageLoaded extends SubredditPageState {
  final List<PostModel> postsInPageModels;
  PostsInPageLoaded(this.postsInPageModels);
}
