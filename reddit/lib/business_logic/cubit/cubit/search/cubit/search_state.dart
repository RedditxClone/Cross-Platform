part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class GetSuggestions extends SearchState {
  final List<List<Map<String, dynamic>>> suggestions;
  GetSuggestions(this.suggestions);
}





