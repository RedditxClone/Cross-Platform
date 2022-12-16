part of 'search_suggestions_cubit.dart';

@immutable
abstract class SearchSuggestionsState {}

class SearchSuggestionsInitial extends SearchSuggestionsState {}

class GetSearchSuggestions extends SearchSuggestionsState {
  final List<List<Map<String, dynamic>>> suggestions;
  GetSearchSuggestions(this.suggestions);
}