import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';

part 'block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  final UserProfileRepository userProfileRepository;
  BlockCubit(this.userProfileRepository) : super(BlockInitial());

  /// [username] : Username of the user to be blocked.
  ///
  /// Emits state [UserBlockedSuccessfully] on blocking a user (if existed), [Error] if not found or if and error occured.
  void blockUser(String username) async {
    if (isClosed) return;
    userProfileRepository.blockUser(username).then((statuscode) {
      if (statuscode == 201) {
        emit(UserBlockedSuccessfully());
      } else {
        emit(Error());
      }
    });
  }
}
