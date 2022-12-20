part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserInfoAvailable extends UserProfileState {
  User userInfo;
  UserInfoAvailable(this.userInfo);
}

class FollowOtherUserSuccess extends UserProfileState {}

class FollowOtherUserNotSuccess extends UserProfileState {}

class UnFollowOtherUserSuccess extends UserProfileState {}

class UnFollowOtherUserNotSuccess extends UserProfileState {}

class UserBlocked extends UserProfileState {}

class ErrorOccured extends UserProfileState {}
