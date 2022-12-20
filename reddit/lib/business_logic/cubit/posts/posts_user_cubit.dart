import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'posts_user_state.dart';

class PostsUserCubit extends Cubit<PostsUserState> {
  final PostsRepository postsRepository;

  List<PostsModel>? posts;
  PostsUserCubit(this.postsRepository) : super(PostsUserInitial());

  /// This function emits:
  /// state [UserPostsLoading] to indicate that data is loading from the server.
  /// state [UserPostsLoaded] when posts are loaded successfully.
  /// This function calls the function [PostsRepository.getMyProfilePosts] to get the user's profile posts.
  void getUserPosts(String id,
      {String sort = "new", int page = 1, int limit = 50}) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    emit(UserPostsLoading());
    postsRepository.getUserPosts(id, sort, page, limit).then((posts) {
      emit(UserPostsLoaded(posts));
      this.posts = posts;
    });
  }
}
