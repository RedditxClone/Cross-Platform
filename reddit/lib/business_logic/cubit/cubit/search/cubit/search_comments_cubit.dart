import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/search_models/search_comments_model.dart';
import '../../../../../data/repository/search_repo.dart';

part 'search_comments_state.dart';

class SearchCommentsCubit extends Cubit<SearchCommentsState> {
  final SearchRepo searchRepo;

  SearchCommentsCubit(this.searchRepo) : super(SearchCommentsInitial());

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the comments for the word we search for.
  /// This function calls the function [SearchRepo.searchComments] which makes the request to the server.
  /// It emits the state [GetSearchComments] which contains the comments.
  void searchComments(String word) {
    searchRepo.searchComments(word).then((value) {
      emit(GetSearchComments(value));
    });
  }
}
