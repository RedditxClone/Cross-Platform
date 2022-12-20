import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/search_models/search_post_model.dart';
import '../../../../../data/repository/search_repo.dart';

part 'search_posts_state.dart';

class SearchPostsCubit extends Cubit<SearchPostsState> {
  final SearchRepo searchRepo;

  SearchPostsCubit(this.searchRepo) : super(SearchPostsInitial());

  /// [word] : [String] The word to search for.
  /// [sort] : [int] The sort type.
  /// [time] : [int] The time type.
  ///
  /// This function makes the request to the server to get the posts for the word we search for.
  /// This function calls the function [SearchRepo.searchPosts] which makes the request to the server.
  /// It emits the state [GetSearchPosts] which contains the posts.
  void searchPosts(String word, int sort, int time) {
    searchRepo.searchPosts(word, sort, time).then((value) {
      emit(GetSearchPosts(value));
    });
  }
}
