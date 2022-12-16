import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';

part 'safety_settings_state.dart';

class SafetySettingsCubit extends Cubit<SafetySettingsState> {
  final SafetySettingsRepository settingsRepository;
  SafetySettings? settings;
  SafetySettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// This function emits state SafetySettingsAvailable on initState of the safetysettings screens.
  ///
  /// This function calls the function [SafetySettingsRepository.getUserSettings] to get all user's safety settings,
  /// then calls [SafetySettingsRepository.getBlockedUsers] to get user's blocked list.
  void getUserSettings() {
    if (isClosed) return;
    settingsRepository.getUserSettings().then((userSettings) {
      // get user safety settings
      settingsRepository.getBlockedUsers().then((blockedList) {
        // get user's blocked list
        userSettings.blocked.clear();
        userSettings.blocked
            .addAll(blockedList.map((e) => User.fromJson(e['blocked'])));
        settings = userSettings;
        debugPrint(settings!.blocked.first.username);
        emit(SafetySettingsAvailable(userSettings));
      });
    });
  }

  /// [settings] : The safety settings model from the safety settings screen that will be updated.
  /// [changed] : A map of the only updated safety settings.
  ///
  /// Emits sate SafetySettingsChanged on changing any value on safety settings page.
  ///
  /// This function calls the function [SafetySettingsRepository.updatePrefs] to update the safety settings.
  void updateSettings(SafetySettings settings, Map changed) {
    if (isClosed) return;
    settingsRepository.updatePrefs(changed).then((val) {
      emit(SafetySettingsChanged(settings));
    });
  }

  /// [settings] : The safety settings model from the safety settings screen that will be updated.
  /// [username] : Username of the user to be blocked.
  ///
  /// Emits sate BlockListUpdated on blocking a user (if existed) from safety settings page.
  ///
  /// This function calls the function [SafetySettingsRepository.checkUsernameAvailable] to check the existance of [username],
  /// then if exist it calls the function [SafetySettingsRepository.blockUser] to block this user.
  void blockUser(SafetySettings settings, String username) async {
    if (isClosed) return;
    settingsRepository.blockUser(username).then((statuscode) {
      this.settings = settings;
      if (statuscode == 201) {
        settingsRepository.getBlockedUsers().then((blockedList) {
          settings.blocked.clear();
          settings.blocked
              .addAll(blockedList.map((e) => User.fromJson(e['blocked'])));
          debugPrint(settings.blocked.first.username);
          emit(BlockListUpdated(settings, username));
        });
      } else {
        emit(ErrorOccured());
      }
    });
  }

  /// [settings] : The safety settings model from the safety settings screen that will be updated.
  /// [username] : Username of the user to be unblocked.
  ///
  /// Emits sate BlockListUpdated on unblocking the user from safety settings pages.
  ///
  /// This function calls the function [SafetySettingsRepository.unBlockUser] to update the safety settings.
  void unBlockUser(SafetySettings settings, String username) {
    if (isClosed) return;
    settingsRepository.unBlockUser(username).then((statuscode) {
      this.settings = settings;
      if (statuscode == 201) {
        settingsRepository.getBlockedUsers().then((blockedList) {
          settings.blocked.clear();
          settings.blocked
              .addAll(blockedList.map((e) => User.fromJson(e['blocked'])));

          emit(BlockListUpdated(settings, username));
        });
      } else {
        emit(ErrorOccured());
      }
    });
  }
}
