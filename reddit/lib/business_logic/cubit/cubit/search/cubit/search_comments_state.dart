part of 'search_comments_cubit.dart';

@immutable
abstract class SearchCommentsState {}

class SearchCommentsInitial extends SearchCommentsState {}

class GetSearchComments extends SearchCommentsState {
  final List<SearchCommentsModel> comments;
  GetSearchComments(this.comments);
}