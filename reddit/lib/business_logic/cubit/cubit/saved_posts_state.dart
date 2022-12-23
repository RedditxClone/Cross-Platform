part of 'saved_posts_cubit.dart';

@immutable
abstract class SavedPostsState {}

class SavedPostsInitial extends SavedPostsState {}

class SavedPostsLoaded extends SavedPostsState {
  final List<SavedPostsModel> savedPosts;

  SavedPostsLoaded(this.savedPosts);
}
