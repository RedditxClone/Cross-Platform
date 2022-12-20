part of 'posts_user_cubit.dart';

@immutable
abstract class PostsUserState {}

class PostsUserInitial extends PostsUserState {}

class UserPostsLoading extends PostsUserState {}

class UserPostsLoaded extends PostsUserState {
  List<PostsModel>? posts;
  UserPostsLoaded(this.posts);
}
