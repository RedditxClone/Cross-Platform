import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  ProfileSettings? settings;
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// This function emits state SettingsAvailable on initState of the profile settings screens.
  ///
  /// This function calls the function [SettingsRepository.getUserSettings] to get all user's profile settings.
  void getUserSettings() {
    if (isClosed) return;
    settingsRepository.getUserSettings().then((userSettings) {
      // get user profile settings
      settings = userSettings;
      UserData.user!.displayName = settings!.displayName;
      UserData.profileSettings = settings;
      emit(SettingsAvailable(userSettings));
    });
  }

  /// [settings] : The profile settings model from the profile settings screen that will be updated.
  /// [img] : The new cover photo as a File.
  ///
  /// Emits sate SettingsChanged on successfully updating cover photo (on mobile).
  void changeCoverphoto(ProfileSettings settings, String img) {
    if (isClosed) return;
    settingsRepository.updateImage('cover', img).then((image) {
      settings.cover = image;
      debugPrint(image);
      UserData.profileSettings!.cover =
          UserData.user!.coverPhoto = settings.cover = image;
      emit(SettingsChanged(settings));
    });
  }

  /// [settings] : The profile settings model from the profile settings screen that will be updated.
  /// [fileAsBytes] : The new cover photo as a Uint8List.
  ///
  /// Emits sate SettingsChanged on successfully updating cover photo (on web).
  ///
  /// This function calls the function [SettingsRepository.updateImageWeb] that updates any photo on web.
  void changeCoverphotoWeb(ProfileSettings settings, Uint8List fileAsBytes) {
    if (isClosed) return;
    settingsRepository.updateImageWeb('cover', fileAsBytes).then((image) {
      UserData.profileSettings!.cover =
          UserData.user!.coverPhoto = settings.cover = image;
      debugPrint(UserData.user!.coverPhoto);
      emit(SettingsChanged(settings));
    });
  }

  /// [settings] : The profile settings model from the profile settings screen that will be updated.
  /// [img] : The new profile photo as a File.
  ///
  /// Emits sate SettingsChanged on successfully updating profile photo (on mobile).
  ///
  /// This function calls the function [SettingsRepository.updateImage] that updates any photo on mobile.
  void changeProfilephoto(ProfileSettings settings, String img) {
    if (isClosed) return;
    settingsRepository.updateImage('profile', img).then((image) {
      settings.profile = image;
      debugPrint(image);
      UserData.user!.profilePic = image;
      emit(SettingsChanged(settings));
    });
  }

  /// [settings] : The profile settings model from the profile settings screen that will be updated.
  /// [fileAsBytes] : The new profile photo as a Uint8List.
  ///
  /// Emits sate SettingsChanged on successfully updating profile photo (on web).
  ///
  /// This function calls the function [SettingsRepository.updateImageWeb] that updates any photo on web.
  void changeProfilephotoWeb(ProfileSettings settings, Uint8List fileAsBytes) {
    if (isClosed) return;
    settingsRepository.updateImageWeb('profile', fileAsBytes).then((image) {
      settings.profile = image;
      UserData.user!.profilePic = image;
      debugPrint(image);
      emit(SettingsChanged(settings));
    });
  }

  /// [settings] : The profile settings model from the profile settings screen that will be updated.
  /// [changed] : A map of the only updated profile settings.
  ///
  /// Emits sate SettingsChanged on changing any value on profile settings pages.
  ///
  /// This function calls the function [SettingsRepository.updatePrefs] to update profile settings.
  void updateSettings(ProfileSettings settings, Map changed) {
    if (isClosed) return;
    settingsRepository.updatePrefs(changed).then((val) {
      print(val);
      if (val == 200) {
        settings.displayName =
            changed['displayName'] != null && changed['displayName'] != ''
                ? changed['displayName']
                : settings.displayName;
        settings.about = changed['about'] != null && changed['about'] != ''
            ? changed['about']
            : settings.about;
        settings.activeInCommunitiesVisibility =
            changed['activeInCommunitiesVisibility'] ??
                settings.activeInCommunitiesVisibility;
        settings.contentVisibility =
            changed['contentVisibility'] ?? settings.contentVisibility;
        UserData.user!.displayName = settings.displayName;
        debugPrint("settings updated : $val");
        UserData.profileSettings = settings;
        emit(SettingsChanged(settings));
      }
    });
  }
}
