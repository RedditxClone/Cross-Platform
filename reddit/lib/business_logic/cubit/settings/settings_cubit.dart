import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  Settings settings = Settings();
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// ### Get the user settings from the repository
  /// this function will be used in the bloc builder widget (UI) to display user settings
  Settings getUserSettings() {
    settingsRepository.getUserSettings().then((userSettings) {
      emit(SettingsAvailable(userSettings));
      settings = userSettings;
    });
    return settings;
  }

  String changeCoverphoto(String img) {
    String newImg = '';
    settingsRepository.updatePrefs('cover', img).then((image) {
      settings.cover = image;
      emit(SettingsChanged(settings));
      newImg = image;
    });
    return newImg;
  }

  String changeProfilephoto(String img) {
    String newImg = '';
    settingsRepository.updatePrefs('profile', img).then((image) {
      settings.profile = image;
      print(image);
      emit(SettingsChanged(settings));
      newImg = image;
    });
    return newImg;
  }

  bool updateactiveInCom(bool newVal) {
    bool ret = true;
    settingsRepository
        .updatePrefs('activeInCommunitiesVisibility', newVal)
        .then((val) {
      settings.activeInCommunitiesVisibility = val;
      emit(SettingsChanged(settings));
      ret = val;
      print(val);
    });
    return ret;
  }
}
