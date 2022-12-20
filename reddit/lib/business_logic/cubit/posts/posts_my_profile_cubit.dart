import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'posts_my_profile_state.dart';

class PostsMyProfileCubit extends Cubit<PostsMyProfileState> {
  final PostsRepository postsRepository;

  List<PostsModel>? posts;
  PostsMyProfileCubit(this.postsRepository) : super(PostsMyProfileInitial());

  /// This function emits:
  /// state [PostsLoading] to indicate that data is loading from the server.
  /// state [PostsLoaded] when posts are loaded successfully.
  /// This function calls the function [PostsRepository.getMyProfilePosts] to get the user's profile posts.
  void getMyProfilePosts() {
    // To avoid state error when you leave the page
    if (isClosed) return;
    emit(PostsLoading());
    postsRepository.getMyProfilePosts().then((posts) {
      emit(PostsLoaded(posts));
      this.posts = posts;
    });
  }
}
