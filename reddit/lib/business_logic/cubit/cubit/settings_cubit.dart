import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  Settings profileSettings = Settings();
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// ### Get the user settings from the repository
  /// this function will be used in the bloc builder widget (UI) to display user settings
  Settings getUserSettings() {
    settingsRepository.getProfileSettings().then((userSettings) {
      emit(SettingsAvailable(userSettings));
      profileSettings = userSettings;
    });
    return profileSettings;
  }
}
