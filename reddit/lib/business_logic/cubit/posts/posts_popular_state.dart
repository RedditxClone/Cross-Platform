part of 'posts_popular_cubit.dart';

@immutable
abstract class PostsPopularState {}

class PostsPopularInitial extends PostsPopularState {}

class PopularPostsLoading extends PostsPopularState {}

class PopularPostsLoaded extends PostsPopularState {
  List<PostsModel>? posts;
  PopularPostsLoaded(this.posts);
}
