part of 'posts_home_cubit.dart';

@immutable
abstract class PostsHomeState {}

class PostsInitial extends PostsHomeState {}

class PostsLoading extends PostsHomeState {}

class PostsLoaded extends PostsHomeState {
  List<PostsModel>? posts;
  PostsLoaded(this.posts);
}
