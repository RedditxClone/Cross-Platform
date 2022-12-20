part of 'follow_unfollow_cubit.dart';

@immutable
abstract class FollowUnfollowState {}

class FollowUnfollowInitial extends FollowUnfollowState {}

class FollowOtherUserSuccess extends FollowUnfollowState {}

class FollowOtherUserNotSuccess extends FollowUnfollowState {}

class UnFollowOtherUserSuccess extends FollowUnfollowState {}

class UnFollowOtherUserNotSuccess extends FollowUnfollowState {}

class UserBlocked extends FollowUnfollowState {}

class ErrorOccured extends FollowUnfollowState {}
