import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/search_models/search_communities_model.dart';
import '../../../../../data/repository/search_repo.dart';

part 'search_communities_state.dart';

class SearchCommunitiesCubit extends Cubit<SearchCommunitiesState> {
  final SearchRepo searchRepo;

  SearchCommunitiesCubit(this.searchRepo) : super(SearchCommunitiesInitial());

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

  /// [communityId] : [String] The id of the community to join.
  ///
  ///  This function makes the request to the server to join the community.
  /// This function calls the function [SearchRepo.joinSubreddit] which makes the request to the server.
  /// It emits the state [JoinCommunity] which contains the result of the request.
  /// If the request is successful it emits the state [JoinCommunity] with the value [true].
  /// If the request is not successful it emits the state [JoinCommunity] with the value [false].
  void joinCommunity(String communityId) {
    searchRepo.joinSubreddit(communityId).then((value) {
      emit(JoinCommunity(value));
    });
  }

  /// [communityId] : [String] The id of the community to leave.
  ///
  /// This function makes the request to the server to leave the community.
  /// This function calls the function [SearchRepo.leaveSubreddit] which makes the request to the server.
  /// It emits the state [LeaveCommunity] which contains the result of the request.
  /// If the request is successful it emits the state [JoinCommunity] with the value [true].
  /// If the request is not successful it emits the state [JoinCommunity] with the value [false].
  void leaveCommunity(String communityId) {
    searchRepo.leaveSubreddit(communityId).then((value) {
      emit(JoinCommunity(value));
    });
  }
}
