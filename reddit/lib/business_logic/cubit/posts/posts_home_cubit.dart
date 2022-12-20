import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'posts_home_state.dart';

class PostsHomeCubit extends Cubit<PostsHomeState> {
  final PostsRepository postsRepository;
  List<PostsModel>? posts;
  PostsHomeCubit(this.postsRepository) : super(PostsInitial());

  /// This function emits:
  /// state [PostsLoading] to indicate that data is loading from the server.
  /// state [PostsLoaded] when posts are loaded successfully.
  /// This function calls the function [PostsRepository.getTimelinePosts] to get the timeline posts.
  void getTimelinePosts({String sort = "new", int page = 1, int limit = 50}) {
    // To avoid state error when you leave the page
    // debugPrint("Sort: $sort");
    if (isClosed) return;
    emit(PostsLoading());
    postsRepository.getTimelinePosts(sort, page, limit).then((posts) {
      emit(PostsLoaded(posts));
      this.posts = posts;
    });
  }
}
