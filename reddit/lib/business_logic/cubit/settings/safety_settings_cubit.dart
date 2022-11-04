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
    settingsRepository.getUserSettings().then((userSettings) {
      emit(SafetySettingsAvailable(userSettings));
      settings = userSettings;
    });
  }

  /// change the cover photo : send to the backend the new image and emit sate SettingsChanged
  void changeCoverphoto(SafetySettings settings, String img) {
    this.settings = settings;
    settingsRepository.updateImage('cover', img).then((image) {
      settings.cover = image;
      emit(SafetySettingsChanged(settings));
    });
  }

  /// change the profile photo : send to the backend the new image and emit sate SettingsChanged
  void changeProfilephoto(String img) {
    settingsRepository.updateImage('profile', img).then((image) {
      settings!.profile = image;
      emit(SafetySettingsChanged(settings!));
    });
  }

  /// update any user settings and emit sate SettingsChanged
  void updateSettings(Map changed) {
    settingsRepository.updatePrefs(changed).then((val) {
      settings!.displayName = val;
      emit(SafetySettingsChanged(settings!));
    });
  }
}
