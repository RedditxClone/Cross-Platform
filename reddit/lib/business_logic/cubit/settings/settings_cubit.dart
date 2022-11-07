import 'dart:io';
import 'dart:typed_data';
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

  /// change the cover photo from mobile: send to the backend the new image
  void changeCoverphoto(Settings settings, File img) {
    settingsRepository.updateImage('coverphoto', img).then((image) {
      settings.cover = image;
      print(image);
      emit(SettingsChanged(settings));
    });
  }

  /// change the cover photo from web: send to the backend the new image
  void changeCoverphotoWeb(Settings settings, Uint8List fileAsBytes) {
    settingsRepository.updateImageWeb('coverphoto', fileAsBytes).then((image) {
      settings.cover = image;
      emit(SettingsChanged(settings));
    });
  }

  /// change the profile photo from mobile: send to the backend the new image
  void changeProfilephoto(Settings settings, File img) {
    settingsRepository.updateImage('profilephoto', img).then((image) {
      settings.profile = image;
      emit(SettingsChanged(settings));
    });
  }

  /// change the profile photo from web: send to the backend the new image
  void changeProfilephotoWeb(Settings settings, Uint8List fileAsBytes) {
    settingsRepository
        .updateImageWeb('profilephoto', fileAsBytes)
        .then((image) {
      settings.profile = image;
      emit(SettingsChanged(settings));
    });
  }

  /// change user profile settings
  void updateSettings(Settings settings, Map changed) {
    settingsRepository.updatePrefs(changed).then((val) {
      settings.displayName = val;
      emit(SettingsChanged(settings));
    });
  }

  // /// change display name of the user
  // bool changeAbout(String newVal) {
  //   bool ret = true;
  //   settingsRepository.updatePrefs('about', newVal).then((val) {
  //     settings!.about = val;
  //     emit(SettingsChanged(settings!));
  //     ret = true;
  //   });
  //   return ret;
  // }

  // /// toggle the value of activeInCommunitiesVisibility : send to the backend the new value
  // bool updateShowactiveInCom(bool newVal) {
  //   bool ret = false;
  //   settingsRepository
  //       .updatePrefs('activeInCommunitiesVisibility', newVal)
  //       .then((val) {
  //     settings!.activeInCommunitiesVisibility = val;
  //     emit(SettingsChanged(settings!));
  //     ret = true;
  //   });
  //   return ret;
  // }

  // /// toggle the value of contentVisibility : send to the backend the new value
  // bool updateContentVisiblity(bool newVal) {
  //   bool ret = false;
  //   settingsRepository.updatePrefs('contentVisibility', newVal).then((val) {
  //     settings!.contentVisibility = val;
  //     emit(SettingsChanged(settings!));
  //     ret = true;
  //   });
  //   return ret;
  // }

  // /// toggle the value of allowPeopleToFollowYou : send to the backend the new value
  // bool updatePeopleToFollowYou(bool newVal) {
  //   bool ret = false;
  //   settingsRepository
  //       .updatePrefs('allowPeopleToFollowYou', newVal)
  //       .then((val) {
  //     settings!.allowPeopleToFollowYou = val;
  //     emit(SettingsChanged(settings!));
  //     ret = true;
  //   });
  //   return ret;
  // }

  // /// toggle the value of nsfw : send to the backend the new value
  // bool updateNSFW(bool newVal) {
  //   bool ret = false;
  //   settingsRepository.updatePrefs('nsfw', newVal).then((val) {
  //     settings!.nsfw = val;
  //     emit(SettingsChanged(settings!));
  //     ret = true;
  //   });
  //   return ret;
  // }
}
