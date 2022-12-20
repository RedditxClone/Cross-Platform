part of 'posts_subreddit_cubit.dart';

@immutable
abstract class PostsSubredditState {}

class PostsSubredditInitial extends PostsSubredditState {}

class SubredditPostsLoading extends PostsSubredditState {}

class SubredditPostsLoaded extends PostsSubredditState {
  List<PostsModel>? posts;
  SubredditPostsLoaded(this.posts);
}
