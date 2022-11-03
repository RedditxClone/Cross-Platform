import 'dart:convert';

import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class SettingsRepository {
  final SettingsWebServices settingsWebServices;
  SettingsRepository(this.settingsWebServices);

  /// Returns all user settings from json to Settings class object
  Future<Settings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return Settings.fromjson(jsonDecode(settings));
  }

  /// patch to update cover and profile photo
  Future<dynamic> updateImage(String key, val) async {
    Map newImage = {key: val};
    final newVal = await settingsWebServices.updatePrefs(newImage);
    return jsonDecode(newVal)[key];
  }

  /// patch to update all user settings
  Future<dynamic> updatePrefs(Map Changed) async {
    final newVal = await settingsWebServices.updatePrefs(Changed);
    return newVal;
  }
}
