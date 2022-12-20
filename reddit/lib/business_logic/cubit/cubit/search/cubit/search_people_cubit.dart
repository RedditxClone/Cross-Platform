import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/auth_model.dart';
import '../../../../../data/repository/search_repo.dart';

part 'search_people_state.dart';

class SearchPeopleCubit extends Cubit<SearchPeopleState> {
  final SearchRepo searchRepo;

  SearchPeopleCubit(this.searchRepo) : super(SearchPeopleInitial());

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the users for the word we search for.
  /// This function calls the function [SearchRepo.searchPeople] which makes the request to the server.
  /// It emits the state [GetSearchPeople] which contains the users.
  void searchPeople(String word) {
    searchRepo.searchPeople(word).then((value) {
      emit(GetSearchPeople(value));
    });
  }

  /// [userId] : [String] The id of the user to follow.
  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to follow the user.
  /// This function calls the function [SearchRepo.follow] which makes the request to the server.
  /// Then it calls the function [searchPeople] to get the users again.
  /// If the user is followed it will be true, otherwise it will be false.
  void follow(String userId, String word) {
    searchRepo.follow(userId).then((value) {
      searchPeople(word);
    });
  }

  /// [userId] : [String] The id of the user to unfollow.
  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to unfollow the user.
  /// This function calls the function [SearchRepo.unfollow] which makes the request to the server.
  /// Then it calls the function [searchPeople] to get the users again.
  /// If the user is followed it will be true, otherwise it will be false.
  void unfollow(String userId, String word) {
    searchRepo.unfollow(userId).then((value) {
      searchPeople(word);
    });
  }
}
