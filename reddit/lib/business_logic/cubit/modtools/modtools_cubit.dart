import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';

part 'modtools_state.dart';

class ModtoolsCubit extends Cubit<ModtoolsState> {
  final ModToolsRepository repository;
  List<User> approvedUsers = [];
  ModtoolsCubit(this.repository) : super(ModtoolsInitial());

  /// This function emits state SettingsAvailable on initState of the profile settings screens.
  ///
  /// This function calls the function [SettingsRepository.getUserSettings] to get all user's profile settings.
  void getApprovedUsers(String subredditID) {
    if (isClosed) return;
    repository.getAprroved(subredditID).then((aprrovedList) {
      // get user profile settings
      approvedUsers.clear();
      approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
      emit(ApprovedListAvailable(approvedUsers));
    });
  }

  /// This function emits state SettingsAvailable on initState of the profile settings screens.
  ///
  /// This function calls the function [SettingsRepository.getUserSettings] to get all user's profile settings.
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

  /// This function emits state SettingsAvailable on initState of the profile settings screens.
  ///
  /// This function calls the function [SettingsRepository.getUserSettings] to get all user's profile settings.
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
