part of 'modtools_cubit.dart';

@immutable
abstract class ModtoolsState {}

class ModtoolsInitial extends ModtoolsState {}

class ApprovedListAvailable extends ModtoolsState {
  List<User> approved;
  ApprovedListAvailable(this.approved);
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
