import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'posts_subreddit_state.dart';

class PostsSubredditCubit extends Cubit<PostsSubredditState> {
  final PostsRepository postsRepository;
  List<PostsModel>? posts;
  PostsSubredditCubit(this.postsRepository) : super(PostsSubredditInitial());

  /// This function emits:
  /// state [SubredditPostsLoading] to indicate that data is loading from the server.
  /// state [SubredditPostsLoaded] when posts are loaded successfully.
  /// This function calls the function [PostsRepository.getSubredditPosts] to get the subreddit posts.
  void getSubredditPosts(String name,
      {String sort = "new", int page = 1, int limit = 50}) {
    // To avoid state error when you leave the page
    // debugPrint("Sort: $sort");
    if (isClosed) return;
    emit(SubredditPostsLoading());
    postsRepository.getSubredditPosts(name, sort, page, limit).then((posts) {
      emit(SubredditPostsLoaded(posts));
      this.posts = posts;
    });
  }
}
