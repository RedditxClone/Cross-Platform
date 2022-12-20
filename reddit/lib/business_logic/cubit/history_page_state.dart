part of 'history_page_cubit.dart';

@immutable
abstract class HistoryPageState {}

class SubredditPageInitial extends HistoryPageState {}

class HistoryPagePostsLoading extends HistoryPageState {}

class ButtonPressed extends HistoryPageState {}
class ChangeUI extends HistoryPageState {}
class HistoryPagePostsLoaded extends HistoryPageState {
  final List<PostModel> subredditsInPageModels;
  HistoryPagePostsLoaded(this.subredditsInPageModels);
}
