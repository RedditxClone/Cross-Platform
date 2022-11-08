part of 'left_drawer_cubit.dart';

@immutable
abstract class LeftDrawerState {}

class LeftDrawerInitial extends LeftDrawerState {}

class LeftDrawerDataLoaded extends LeftDrawerState {
  final List<LeftDrawerModel> moderating;
  final List<LeftDrawerModel> yourCommunities;
  final List<LeftDrawerModel> following;

  LeftDrawerDataLoaded(this.moderating, this.yourCommunities, this.following);
}

class ModeratingCommunitiesLoaded extends LeftDrawerState {
  final List<LeftDrawerModel> leftDrawerCommunityModel;

  ModeratingCommunitiesLoaded(this.leftDrawerCommunityModel);
}

class YourCommunitiesLoaded extends LeftDrawerState {
  final List<LeftDrawerModel> leftDrawerCommunityModel;

  YourCommunitiesLoaded(this.leftDrawerCommunityModel);
}

class FollowingUsersLoaded extends LeftDrawerState {
  final List<LeftDrawerModel> leftDrawerCommunityModel;

  FollowingUsersLoaded(this.leftDrawerCommunityModel);
}
