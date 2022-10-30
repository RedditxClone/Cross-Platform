import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  Settings settings = Settings();
  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  /// Get all user settings @initial build of any settings widget
  Settings getUserSettings() {
    settingsRepository.getUserSettings().then((userSettings) {
      emit(SettingsAvailable(userSettings));
      settings = userSettings;
    });
    return settings;
  }

  /// change the cover photo : send to the backend the new image
  String changeCoverphoto(String img) {
    String newImg = '';
    settingsRepository.updatePrefs('cover', img).then((image) {
      settings.cover = image;
      emit(SettingsChanged(settings));
      newImg = image;
    });
    return newImg;
  }

  /// change the profile photo : send to the backend the new image
  String changeProfilephoto(String img) {
    String newImg = '';
    settingsRepository.updatePrefs('profile', img).then((image) {
      settings.profile = image;
      emit(SettingsChanged(settings));
      newImg = image;
    });
    return newImg;
  }

  /// change display name of the user
  bool changeDisplayName(String newVal) {
    bool ret = true;
    settingsRepository.updatePrefs('displayName', newVal).then((val) {
      settings.displayName = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// change display name of the user
  bool changeAbout(String newVal) {
    bool ret = true;
    settingsRepository.updatePrefs('about', newVal).then((val) {
      settings.about = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of activeInCommunitiesVisibility : send to the backend the new value
  bool updateShowactiveInCom(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('activeInCommunitiesVisibility', newVal)
        .then((val) {
      settings.activeInCommunitiesVisibility = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of contentVisibility : send to the backend the new value
  bool updateContentVisiblity(bool newVal) {
    bool ret = false;
    settingsRepository.updatePrefs('contentVisibility', newVal).then((val) {
      settings.contentVisibility = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of allowPeopleToFollowYou : send to the backend the new value
  bool updatePeopleToFollowYou(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('allowPeopleToFollowYou', newVal)
        .then((val) {
      settings.allowPeopleToFollowYou = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of nsfw : send to the backend the new value
  bool updateNSFW(bool newVal) {
    bool ret = false;
    settingsRepository.updatePrefs('nsfw', newVal).then((val) {
      settings.nsfw = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of disroptiveSettings : send to the backend the new value
  bool updateDisroptiveSettings(String newVal) {
    bool ret = false;
    settingsRepository.updatePrefs('disroptiveSettings', newVal).then((val) {
      settings.disroptiveSettings = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of showUnInSearch : send to the backend the new value
  bool updateShowUnInSearch(bool newVal) {
    bool ret = false;
    settingsRepository.updatePrefs('showUnInSearch', newVal).then((val) {
      settings.showUnInSearch = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of personalizeAds_information : send to the backend the new value
  bool updatePersonalizeAdsInformation(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('personalizeAds_information', newVal)
        .then((val) {
      settings.personalizeAdsInformation = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of personalizeAds_yourActivity : send to the backend the new value
  bool updatePersonalizeAdsYourActivity(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('personalizeAds_yourActivity', newVal)
        .then((val) {
      settings.personalizeAdsYourActivity = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of personalizeRec_generalLocation : send to the backend the new value
  bool updatePersonalizeAllOfReddit(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('personalizeRec_generalLocation', newVal)
        .then((val) {
      settings.personalizeAllOfReddit = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of personalizeRec_ourPartners : send to the backend the new value
  bool updatePersonalizeRecOurPartners(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('personalizeRec_ourPartners', newVal)
        .then((val) {
      settings.personalizeRecOurPartners = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }

  /// toggle the value of useTwoFactorAuthentication : send to the backend the new value
  bool updateUseTwoFactorAuthentication(bool newVal) {
    bool ret = false;
    settingsRepository
        .updatePrefs('useTwoFactorAuthentication', newVal)
        .then((val) {
      settings.useTwoFactorAuthentication = val;
      emit(SettingsChanged(settings));
      ret = true;
    });
    return ret;
  }
}
