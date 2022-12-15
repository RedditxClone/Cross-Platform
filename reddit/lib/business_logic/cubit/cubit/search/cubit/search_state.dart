part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class GetSuggestions extends SearchState {
  final List<List<Map<String, dynamic>>> suggestions;
  GetSuggestions(this.suggestions);
}

class GetSearchUsers extends SearchState {
  final List<User> users;
  GetSearchUsers(this.users);
}

class GetSearchPosts extends SearchState {
  final List<SearchPostModel> posts;
  GetSearchPosts(this.posts);
}

class GetSearchCommunities extends SearchState {
  final List<SearchComminityModel> communities;
  GetSearchCommunities(this.communities);
}

class GetSearchComments extends SearchState {
  final List<SearchCommentsModel> comments;
  GetSearchComments(this.comments);
}
