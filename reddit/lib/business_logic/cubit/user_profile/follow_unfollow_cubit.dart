import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';

part 'follow_unfollow_state.dart';

class FollowUnfollowCubit extends Cubit<FollowUnfollowState> {
  final UserProfileRepository userProfileRepository;
  FollowUnfollowCubit(this.userProfileRepository)
      : super(FollowUnfollowInitial());

  /// [userID] : The ID of the user to be followed
  ///
  /// Emits sate [FollowOtherUserSuccess] on successfully following this user and [FollowOtherUserNotSuccess] if the follow failed
  ///
  void follow(String userID) {
    if (isClosed) return;
    userProfileRepository.follow(userID).then((value) {
      if (value == 201) {
        emit(FollowOtherUserSuccess());
      } else {
        emit(FollowOtherUserNotSuccess());
      }
    });
  }

  /// [userID] : The ID of the user to be unfollowed
  ///
  /// Emits sate [UnFollowOtherUserSuccess] on successfully following this user and [UnFollowOtherUserNotSuccess] if the follow failed
  ///
  void unfollow(String userID) {
    if (isClosed) return;
    userProfileRepository.unfollow(userID).then((value) {
      if (value == 201) {
        emit(UnFollowOtherUserSuccess());
      } else {
        emit(UnFollowOtherUserNotSuccess());
      }
    });
  }
}
