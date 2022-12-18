import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'modtools_state.dart';

class ModtoolsCubit extends Cubit<ModtoolsState> {
  final ModToolsRepository repository;
  List<User> approvedUsers = [];
  List<PostsModel> modToolsPosts = [];
  ModtoolsCubit(this.repository) : super(ModtoolsInitial());

  /// [subredditID] is the id of subreddit to which we get the edited posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getEditedPosts(String subredditID) {
    if (isClosed) return;
    emit(Loading());
    repository.getEditedPosts(subredditID).then((posts) {
      emit(EditedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditID] is the id of subreddit to which we get the spammed posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getSpammedPosts(String subredditID) {
    if (isClosed) return;
    emit(Loading());
    repository.getSpammedPosts(subredditID).then((posts) {
      emit(SpammedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditID] is the id of subreddit to which we get the unmoderated posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getUnmoderatedPosts(String subredditID) {
    if (isClosed) return;
    emit(Loading());
    repository.getUnmoderatedPosts(subredditID).then((posts) {
      emit(UnmoderatedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditID] is the id of subreddit to which we get the approved list
  /// This function emits state [ApprovedListAvailable] on initState of the `UserManagement` widget.
  void getApprovedUsers(String subredditID) {
    if (isClosed) return;
    emit(Loading());
    repository.getAprroved(subredditID).then((aprrovedList) {
      // get user profile settings
      approvedUsers.clear();
      approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
      emit(ApprovedListAvailable(approvedUsers));
    });
  }

  /// [subredditID] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// This function emits state [AddedToApprovedUsers] adding a new user to the approved list.
  void addApprovedUser(String subredditID, String username) {
    if (isClosed) return;
    repository.addApprovedUser(subredditID, username).then((statusCode) {
      repository.getAprroved(subredditID).then((aprrovedList) {
        approvedUsers.clear();
        approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
        emit(AddedToApprovedUsers(approvedUsers));
      });
    });
  }

  /// [subredditID] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// This function emits state [RemovedFromApprovedUsers] removing a user from the approved list.
  void removeApprovedUser(String subredditID, String username) {
    if (isClosed) return;
    repository.removeApprovedUser(subredditID, username).then((statusCode) {
      repository.getAprroved(subredditID).then((aprrovedList) {
        approvedUsers.clear();
        approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
        emit(RemovedFromApprovedUsers(approvedUsers));
      });
    });
  }
}
