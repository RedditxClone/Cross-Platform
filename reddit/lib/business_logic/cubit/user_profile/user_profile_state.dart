part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class FollowOtherUserSuccess extends UserProfileState {}

class FollowOtherUserNotSuccess extends UserProfileState {}

class UnFollowOtherUserSuccess extends UserProfileState {}

class UnFollowOtherUserNotSuccess extends UserProfileState {}
