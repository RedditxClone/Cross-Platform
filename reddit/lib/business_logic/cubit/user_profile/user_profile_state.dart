part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserInfoAvailable extends UserProfileState {
  User userInfo;
  UserInfoAvailable(this.userInfo);
}

class MyModSubredditsAvailable extends UserProfileState {
  List<ModeratingSubredditsDrawerModel> modSubreddits;
  MyModSubredditsAvailable(this.modSubreddits);
}

class UserBlocked extends UserProfileState {}

class ErrorOccured extends UserProfileState {}
