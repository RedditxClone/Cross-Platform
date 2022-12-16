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

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the users for the word we search for.
  /// This function calls the function [SearchRepo.searchPeople] which makes the request to the server.
  /// It emits the state [GetSearchUsers] which contains the users.
  void searchPeople(String word) {
    searchRepo.searchPeople(word).then((value) {
      emit(GetSearchUsers(value));
    });
  }

  /// [word] : [String] The word to search for.
  /// [sort] : [int] The sort type.
  /// [time] : [int] The time type.
  ///
  /// This function makes the request to the server to get the posts for the word we search for.
  /// This function calls the function [SearchRepo.searchPosts] which makes the request to the server.
  /// It emits the state [GetSearchPosts] which contains the posts.
  void searchPosts(String word, int sort,int time) {
    searchRepo.searchPosts(word, sort,time).then((value) {
      emit(GetSearchPosts(value));
    });
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the communities for the word we search for.
  /// This function calls the function [SearchRepo.searchCommunities] which makes the request to the server.
  /// It emits the state [GetSearchCommunities] which contains the communities.
  void searchCommunities(String word) {
    searchRepo.searchCommunities(word).then((value) {
      emit(GetSearchCommunities(value));
    });
  }

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
