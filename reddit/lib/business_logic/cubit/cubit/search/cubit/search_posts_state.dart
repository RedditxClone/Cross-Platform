part of 'search_posts_cubit.dart';

@immutable
abstract class SearchPostsState {}

class SearchPostsInitial extends SearchPostsState {}

class GetSearchPosts extends SearchPostsState {
  final List<SearchPostModel> posts;
  GetSearchPosts(this.posts);
}