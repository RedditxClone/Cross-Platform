import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';

part 'safety_settings_state.dart';

class SafetySettingsCubit extends Cubit<SafetySettingsState> {
  final SafetySettingsRepository settingsRepository;
  SafetySettings? settings;
  SafetySettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// Get all user settings @initial build of any settings widget
  void getUserSettings() {
    if (isClosed) return;
    settingsRepository.getUserSettings().then((userSettings) {
      settingsRepository.getBlockedUsers().then((blockedList) {
        userSettings.blocked = blockedList;
        settings = userSettings;
        emit(SafetySettingsAvailable(userSettings));
      });
    });
  }

  /// update any user settings and emit sate SettingsChanged
  void updateSettings(SafetySettings settings, Map changed) {
    if (isClosed) return;
    settingsRepository.updatePrefs(changed).then((val) {
      emit(SafetySettingsChanged(settings));
    });
  }

  /// Block a user by his/her username if existed in the database
  void blockUser(SafetySettings settings, String username) async {
    if (isClosed) return;
    await settingsRepository
        .checkUsernameAvailable(username)
        .then((usernameExist) {
      //if this username exist
      if (usernameExist == 200) {
        //block the user
        settingsRepository.blockUser(username).then((val) {
          settings.blocked.add(username);
          emit(BlockListUpdated(settings, username));
        });
      }
    });
  }

  /// unBlock a user by his/her username
  void unBlockUser(SafetySettings settings, String username) {
    if (isClosed) return;
    //block the user
    settingsRepository.unBlockUser(username).then((usernameExist) {
      if (usernameExist == 200) {
        settings.blocked.remove(username);
        emit(BlockListUpdated(settings, username));
      }
    });
  }
}
