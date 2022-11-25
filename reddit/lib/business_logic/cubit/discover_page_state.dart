part of 'discover_page_cubit.dart';

@immutable
abstract class DiscoverPageState {}

class DiscoverPageInitial extends DiscoverPageState {}

/// Random Posts retrieved successfully from server and ready to be displayed
class RandomPostsLoaded extends DiscoverPageState {
  final List<DiscoverPageModel> randomPostss;

  RandomPostsLoaded(this.randomPostss);
}
