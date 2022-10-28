import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/profile_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  ProfileSettings profileSettings = ProfileSettings();
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  ProfileSettings getUserSettings() {
    settingsRepository.getProfileSettings().then((userSettings) {
      emit(SettingsAvailable(userSettings));
      profileSettings = userSettings;
    });
    return profileSettings;
  }
}
