import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepository userProfileRepository;
  UserProfileCubit(this.userProfileRepository) : super(UserProfileInitial());

  late User userInfo;

  /// [userID] : The ID of the user we are inside his profile
  ///
  /// Emits sate [UserInfoAvailable] on getting user info
  ///
  void getUserInfo(String userID) {
    if (isClosed) return;
    userProfileRepository.getUserInfo(userID).then((value) {
      userInfo = value;
      print(value);
      emit(UserInfoAvailable(userInfo));
    });
  }

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

  /// [userID] : The ID of the user to be followed
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
