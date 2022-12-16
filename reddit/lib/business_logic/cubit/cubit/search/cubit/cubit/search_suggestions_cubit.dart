import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../data/repository/search_repo.dart';

part 'search_suggestions_state.dart';

class SearchSuggestionsCubit extends Cubit<SearchSuggestionsState> {
  final SearchRepo searchRepo;

  SearchSuggestionsCubit(this.searchRepo) : super(SearchSuggestionsInitial());

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the suggestions for the word we search for.
  /// This function calls the function [SearchRepo.getSuggestions] which makes the request to the server.
  /// It emits the state [GetSuggestions] which contains the suggested users and subreddits.
  void getSuggestions(String word) {
    searchRepo.getSuggestions(word).then((value) {
      emit(GetSearchSuggestions(value));
    });
  }
}
