part of 'search_communities_cubit.dart';

@immutable
abstract class SearchCommunitiesState {}

class SearchCommunitiesInitial extends SearchCommunitiesState {}

class GetSearchCommunities extends SearchCommunitiesState {
  final List<SearchComminityModel> communities;
  GetSearchCommunities(this.communities);
}
