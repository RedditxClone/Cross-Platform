import 'dart:convert';

import 'package:reddit/data/model/profile_settings.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class SettingsRepository {
  final SettingsWebServices settingsWebServices;
  SettingsRepository(this.settingsWebServices);

  Future<ProfileSettings> getProfileSettings() async {
    final settings = await settingsWebServices.getProfileSettings();
    return ProfileSettings.fromjson(
        jsonDecode(settings)); //try jsondecode(settings)
  }
}
