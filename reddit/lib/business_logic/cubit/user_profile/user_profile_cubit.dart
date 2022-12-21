import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/left_drawer/moderating_subreddits_left_drawer_model.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepository userProfileRepository;
  UserProfileCubit(this.userProfileRepository) : super(UserProfileInitial());

  late User userInfo;

  /// [userID] : The ID of the user we are inside his profile
  ///
  /// Emits state [UserInfoAvailable] on getting user info
  void getUserInfo(String userID) {
    if (isClosed) return;
    userProfileRepository.getUserInfo(userID).then((value) {
      userInfo = value;
      print(value);
      emit(UserInfoAvailable(userInfo));
    });
  }

  /// Emits state [MyModSubredditsAvailable] on getting the subreddits to which the user is a moderator
  void getMyModeratedSubreddits() {
    if (isClosed) return;
    userProfileRepository.getMyModeratedSubreddits().then((value) {
      emit(MyModSubredditsAvailable(value));
    });
  }

  /// [subredditId] : the id of subreddit to leave.
  ///
  /// Emits state [MyModSubredditsAvailable] on successfully leaving subreddit that returns the new subreddit list after modification.
  void leaveSubreddit(String subredditId) {
    if (isClosed) return;
    userProfileRepository.leaveSubreddit(subredditId).then((statusCode) {
      if (statusCode == 201) {
        userProfileRepository.getMyModeratedSubreddits().then((value) {
          emit(MyModSubredditsAvailable(value));
        });
      }
    });
  }

  /// [username] : Username of the user to be blocked.
  ///
  /// Emits state [UserBlocked] on blocking a user (if existed), [ErrorOccured] if not found or if and error occured.
  void blockUser(String username) async {
    if (isClosed) return;
    userProfileRepository.blockUser(username).then((statuscode) {
      if (statuscode == 201) {
        emit(UserBlocked());
      } else {
        emit(ErrorOccured());
      }
    });
  }
}
