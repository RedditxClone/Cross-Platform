import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'posts_popular_state.dart';

class PostsPopularCubit extends Cubit<PostsPopularState> {
  final PostsRepository postsRepository;
  List<PostsModel>? posts;
  PostsPopularCubit(this.postsRepository) : super(PostsPopularInitial());

  /// This function emits:
  /// state [PopularPostsLoading] to indicate that data is loading from the server.
  /// state [PopularPostsLoaded] when posts are loaded successfully.
  /// This function calls the function [PostsRepository.getPopularPosts] to get the timeline posts.
  void getPopularPosts({String sort = "new", int page = 1, int limit = 50}) {
    // To avoid state error when you leave the page
    // debugPrint("Sort: $sort");
    if (isClosed) return;
    emit(PopularPostsLoading());
    postsRepository.getPopularPosts(sort, page, limit).then((posts) {
      emit(PopularPostsLoaded(posts));
      this.posts = posts;
    });
  }
}
