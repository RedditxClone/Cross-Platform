import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/modtools/taffic_stats_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';

part 'modtools_state.dart';

class ModtoolsCubit extends Cubit<ModtoolsState> {
  final ModToolsRepository repository;
  List<User> approvedUsers = [];
  List<PostsModel> modToolsPosts = [];
  ModtoolsCubit(this.repository) : super(ModtoolsInitial());

  /// [subredditID] is the id of subreddit to which we get the edited posts list
  /// [subredditName] is the name of subreddit to which we get the edited posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getEditedPosts(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getEditedPosts(subredditName).then((posts) {
      emit(EditedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditName] is the id of subreddit to which we get the spammed posts list
  /// [subredditName] is the name of subreddit to which we get the spammed posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getSpammedPosts(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getSpammedPosts(subredditName).then((posts) {
      emit(SpammedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditName] is the name of subreddit to which we get the unmoderated posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getUnmoderatedPosts(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getUnmoderatedPosts(subredditName).then((posts) {
      emit(UnmoderatedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditName] is the name of subreddit to which we get the traffic stats
  /// This function emits state [TrafficStatsAvailable] on initState of the `Traffic stats` page.
  void getStatistics(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getStatistics(subredditName).then((statistics) {
      emit(TrafficStatsAvailable(statistics));
    });
  }

  /// [subredditId] is the id of subreddit to which we get the approved list
  /// This function emits state [ApprovedListAvailable] on initState of the `UserManagement` widget.
  void getApprovedUsers(String subredditId) {
    if (isClosed) return;
    emit(Loading());
    repository.getAprroved(subredditId).then((aprrovedList) {
      approvedUsers.clear();
      approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
      emit(ApprovedListAvailable(approvedUsers));
    });
  }

  /// [subredditId] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// This function emits state [AddedToApprovedUsers] on adding a new user to the approved list or if the user already existed.
  void addApprovedUser(String subredditId, String username) {
    if (isClosed) return;
    bool usernameExist = false;
    approvedUsers.forEach((user) {
      if (user.username == username) {
        usernameExist = true;
      }
    });

    if (usernameExist) {
      repository.getAprroved(subredditId).then((aprrovedList) {
        approvedUsers.clear();
        approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
        emit(AddedToApprovedUsers(approvedUsers));
        debugPrint('username : $username already exist');
        return;
      });
    } else {
      repository.addApprovedUser(subredditId, username).then((statusCode) {
        if (statusCode == 201) {
          repository.getAprroved(subredditId).then((aprrovedList) {
            approvedUsers.clear();
            approvedUsers
                .addAll(aprrovedList.map((user) => User.fromJson(user)));
            emit(AddedToApprovedUsers(approvedUsers));
          });
        } else {
          emit(WrongUsername());
        }
      });
    }
  }

  /// [subredditId] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// This function emits state [RemovedFromApprovedUsers] removing a user from the approved list.
  void removeApprovedUser(String subredditId, String username) {
    if (isClosed) return;
    repository.removeApprovedUser(subredditId, username).then((statusCode) {
      repository.getAprroved(subredditId).then((aprrovedList) {
        approvedUsers.clear();
        approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
        emit(RemovedFromApprovedUsers(approvedUsers));
      });
    });
  }

  /// [subredditId] is the id of subreddit to which we get the moderators list
  ///
  /// This function emits state [ModeratorsListAvailable]
  void getModerators(String subredditId) {
    if (isClosed) return;
    repository.getModerators(subredditId).then((moderatorsList) {
      emit(ModeratorsListAvailable(moderatorsList));
    });
  }

  /// [subredditId] is the id of subreddit to which we add a moderator
  /// [username] is the username of the user to be added as a moderator
  ///
  /// This function emits state [AddedToModerators] on adding a new moderator or if the user already existed.
  void addModerator(String subredditId, String username) {
    repository.addModerator(subredditId, username).then((value) {
      emit(AddedToModerators(value));
    });
  }

  /// [subredditId] is the id of subreddit to add new user to the muted list
  /// [username] is the username of the user to be added to the muted list
  /// [muteReason] is the reason for muting the user
  ///
  /// This function emits state [MuteUser] on adding a new user to the muted list or if the user already existed.
  void muteUser(String subredditId, String username, String muteReason) {
    repository.muteUser(subredditId, username, muteReason).then((value) {
      emit(MuteUser(value));
    });
  }

  /// [subredditId] is the id of subreddit to get the muted list
  ///
  /// This function emits state [MutedListAvailable]
  void getMutedUsers(String subredditId) {
    repository.getMutedUsers(subredditId).then((value) {
      emit(MutedListAvailable(value));
    });
  }

  /// [subredditId] is the id of subreddit to get the banned list
  ///
  /// This function emits state [BannedListAvailable]
  void getBannedUsers(String subredditId) {
    repository.getBannedUsers(subredditId).then((value) {
      emit(BannedListAvailable(value));
    });
  }

  /// [subredditId] is the id of subreddit to add new user to the banned list
  /// [username] is the username of the user to be added to the banned list
  /// [banReason] is the reason for banning the user
  /// [banDays] is the duration for which the user is banned
  /// [modNote] is the note for banning the user
  /// [banMessage] is the message to be sent to the user
  /// [permanent] is the boolean value to ban the user permanently
  ///
  /// This function emits state [BanUser] on adding a new user to the banned list or if the user already existed.
  void banUser(String subredditId, String username, String banReason,
      int banDays, String modNote, String banMessage, bool permanent) {
    repository
        .banUser(subredditId, username, banReason, banDays, modNote, banMessage,
            permanent)
        .then((value) {
      emit(BanUser(value));
    });
  }
}
