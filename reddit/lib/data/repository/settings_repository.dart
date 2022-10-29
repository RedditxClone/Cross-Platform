import 'dart:convert';

import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class SettingsRepository {
  final SettingsWebServices settingsWebServices;
  SettingsRepository(this.settingsWebServices);

  /// ### Returns all user settings from json to Settings class object
  Future<Settings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return Settings.fromjson(jsonDecode(settings));
  }

  Future<dynamic> updatePrefs(String key, val) async {
    final newImg = await settingsWebServices.updatePrefs(key, val);
    return jsonDecode(newImg)[key];
  }
}
