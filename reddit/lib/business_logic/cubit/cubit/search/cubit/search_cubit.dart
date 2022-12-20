import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/auth_model.dart';
import '../../../../../data/model/search_models/search_comments_model.dart';
import '../../../../../data/model/search_models/search_communities_model.dart';
import '../../../../../data/model/search_models/search_post_model.dart';
import '../../../../../data/repository/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitial());

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the suggestions for the word we search for.
  /// This function calls the function [SearchRepo.getSuggestions] which makes the request to the server.
  /// It emits the state [GetSuggestions] which contains the suggested users and subreddits.
  void getSuggestions(String word) {
    searchRepo.getSuggestions(word).then((value) {
      emit(GetSuggestions(value));
    });
  }
}
