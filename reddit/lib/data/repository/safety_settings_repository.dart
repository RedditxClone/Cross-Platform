import 'dart:convert';

import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';

class SafetySettingsRepository {
  final SafetySettingsWebServices settingsWebServices;
  SafetySettingsRepository(this.settingsWebServices);

  /// Returns all user settings from json to Settings class object
  Future<SafetySettings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return SafetySettings.fromjson(jsonDecode(settings));
  }

  /// patch to update cover and profile photo
  Future<dynamic> updateImage(String key, val) async {
    Map newImage = {key: val};
    final newVal = await settingsWebServices.updatePrefs(newImage);
    return jsonDecode(newVal)[key];
  }

  /// patch to update all user settings
  Future<dynamic> updatePrefs(Map changed) async {
    final newVal = await settingsWebServices.updatePrefs(changed);
    return newVal;
  }
}
