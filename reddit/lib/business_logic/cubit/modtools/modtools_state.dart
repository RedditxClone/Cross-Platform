part of 'modtools_cubit.dart';

abstract class ModtoolsState {}

class ModtoolsInitial extends ModtoolsState {}

class ApprovedListAvailable extends ModtoolsState {
  List<User> approved;
  ApprovedListAvailable(this.approved);
}

class TrafficStatsAvailable extends ModtoolsState {
  List<TrafficStats> tafficstats;
  TrafficStatsAvailable(this.tafficstats);
}

class AddedToApprovedUsers extends ModtoolsState {
  List<User> approved;
  AddedToApprovedUsers(this.approved);
}

class WrongUsername extends ModtoolsState {
  WrongUsername();
}

class RemovedFromApprovedUsers extends ModtoolsState {
  List<User> approved;
  RemovedFromApprovedUsers(this.approved);
}

class EditedPostsReady extends ModtoolsState {
  List<PostsModel> posts;
  EditedPostsReady(this.posts);
}

class SpammedPostsReady extends ModtoolsState {
  List<PostsModel> posts;
  SpammedPostsReady(this.posts);
}

class UnmoderatedPostsReady extends ModtoolsState {
  List<PostsModel> posts;
  UnmoderatedPostsReady(this.posts);
}

class Loading extends ModtoolsState {}

class ModeratorsListAvailable extends ModtoolsState {
  List<User> moderators;
  ModeratorsListAvailable(this.moderators);
}

class AddedToModerators extends ModtoolsState {
  int statusCode;
  AddedToModerators(this.statusCode);
}

class MutedListAvailable extends ModtoolsState {
  List<User> mutedUsers;
  MutedListAvailable(this.mutedUsers);
}

class BannedListAvailable extends ModtoolsState {
  List<User> bannedUsers;
  BannedListAvailable(this.bannedUsers);
}

class MuteUser extends ModtoolsState {
  int statusCode;
  MuteUser(this.statusCode);
}

class BanUser extends ModtoolsState {
  int statusCode;
  BanUser(this.statusCode);
}
