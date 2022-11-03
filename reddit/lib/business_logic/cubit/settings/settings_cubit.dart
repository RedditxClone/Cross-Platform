import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  Settings? settings;
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// Get all user settings @initial build of any settings widget
  void getUserSettings() {
    settingsRepository.getUserSettings().then((userSettings) {
      emit(SettingsAvailable(userSettings));
      settings = userSettings;
    });
  }

  /// change the cover photo : send to the backend the new image
  String changeCoverphoto(Settings settings, String img) {
    String newImg = '';
    this.settings = settings;
    settingsRepository.updateImage('cover', img).then((image) {
      settings.cover = image;
      emit(SettingsChanged(settings));
      newImg = image;
    });
    return newImg;
  }

  /// change the profile photo : send to the backend the new image
  String changeProfilephoto(String img) {
    String newImg = '';
    settingsRepository.updateImage('profile', img).then((image) {
      settings!.profile = image;
      emit(SettingsChanged(settings!));
      newImg = image;
    });
    return newImg;
  }

  /// change display name of the user
  int updateSettings(Map changed) {
    int statusCode = 500;
    settingsRepository.updatePrefs(changed).then((val) {
      settings!.displayName = val;
      emit(SettingsChanged(settings!));
    });
    return statusCode;
  }
}
