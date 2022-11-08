part of 'left_drawer_cubit.dart';

@immutable
abstract class LeftDrawerState {}

class LeftDrawerInitial extends LeftDrawerState {}

class LeftDrawerDataLoaded extends LeftDrawerState {
  final List<LeftDrawerModel> moderating;
  final List<LeftDrawerModel> yourCommunities;
  final List<LeftDrawerModel> following;
  final List<LeftDrawerModel> favorites;

  LeftDrawerDataLoaded(
      this.moderating, this.yourCommunities, this.following, this.favorites);
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
