part of 'left_drawer_cubit.dart';

@immutable
abstract class LeftDrawerState {}

class LeftDrawerInitial extends LeftDrawerState {}

/// Emitted when (moderatingCommunities [moderating], joined communities [yourCommunities], following users [following], favorites [favorites]) are loaded successfully].
class LeftDrawerDataLoaded extends LeftDrawerState {
  final List<ModeratingSubredditsDrawerModel> moderating;
  final List<JoinedSubredditsDrawerModel> yourCommunities;
  final FollowingUsersDrawerModel following;
  final List<FollowingUsersDrawerModel> favorites;

  LeftDrawerDataLoaded(
      this.moderating, this.yourCommunities, this.following, this.favorites);
}

class ModeratingCommunitiesLoaded extends LeftDrawerState {
  final List<FollowingUsersDrawerModel> leftDrawerCommunityModel;

  ModeratingCommunitiesLoaded(this.leftDrawerCommunityModel);
}

class YourCommunitiesLoaded extends LeftDrawerState {
  final List<FollowingUsersDrawerModel> leftDrawerCommunityModel;

  YourCommunitiesLoaded(this.leftDrawerCommunityModel);
}

class FollowingUsersLoaded extends LeftDrawerState {
  final FollowingUsersDrawerModel leftDrawerFollowingModel;

  FollowingUsersLoaded(this.leftDrawerFollowingModel);
}
