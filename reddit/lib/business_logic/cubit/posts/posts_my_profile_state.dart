part of 'posts_my_profile_cubit.dart';

@immutable
abstract class PostsMyProfileState {}

class PostsMyProfileInitial extends PostsMyProfileState {}

class PostsLoading extends PostsMyProfileState {}

class PostsLoaded extends PostsMyProfileState {
  List<PostsModel>? posts;
  PostsLoaded(this.posts);
}
