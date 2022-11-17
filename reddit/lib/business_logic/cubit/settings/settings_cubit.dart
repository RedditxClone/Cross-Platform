import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  ProfileSettings? settings;
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// Get all user settings @initial build of any settings widget
  void getUserSettings() {
    if (isClosed) return;
    settingsRepository.getUserSettings().then((userSettings) {
      emit(SettingsAvailable(userSettings));
      settings = userSettings;
    });
  }

  /// change the cover photo from mobile: send to the backend the new image
  void changeCoverphoto(ProfileSettings settings, File img) {
    if (isClosed) return;
    settingsRepository.updateImage('coverphoto', img).then((image) {
      settings.cover = image;
      debugPrint(image);
      emit(SettingsChanged(settings));
    });
  }

  /// change the cover photo from web: send to the backend the new image
  void changeCoverphotoWeb(ProfileSettings settings, Uint8List fileAsBytes) {
    if (isClosed) return;
    settingsRepository.updateImageWeb('coverphoto', fileAsBytes).then((image) {
      settings.cover = image;
      debugPrint(image);
      emit(SettingsChanged(settings));
    });
  }

  /// change the profile photo from mobile: send to the backend the new image
  void changeProfilephoto(ProfileSettings settings, File img) {
    if (isClosed) return;
    settingsRepository.updateImage('profilephoto', img).then((image) {
      settings.profile = image;
      debugPrint(image);
      emit(SettingsChanged(settings));
    });
  }

  /// change the profile photo from web: send to the backend the new image
  void changeProfilephotoWeb(ProfileSettings settings, Uint8List fileAsBytes) {
    if (isClosed) return;
    settingsRepository
        .updateImageWeb('profilephoto', fileAsBytes)
        .then((image) {
      settings.profile = image;
      debugPrint(image);
      emit(SettingsChanged(settings));
    });
  }

  /// change user profile settings
  void updateSettings(ProfileSettings settings, Map changed) {
    if (isClosed) return;
    settingsRepository.updatePrefs(changed).then((val) {
      settings.displayName = val;
      emit(SettingsChanged(settings));
    });
  }
}
