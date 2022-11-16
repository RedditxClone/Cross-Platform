import 'dart:io';
import 'dart:typed_data';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class SettingsRepository {
  final SettingsWebServices settingsWebServices;
  SettingsRepository(this.settingsWebServices);

  /// ### Returns all user settings from json to Settings class object
  Future<ProfileSettings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return ProfileSettings.fromjson(settings);
  }

  Future<dynamic> updateImage(String key, File val) async {
    final newVal = await settingsWebServices.updateImage(val, key);
    return newVal[key];
  }

  Future<dynamic> updateImageWeb(String key, Uint8List fileAsBytes) async {
    final newVal = await settingsWebServices.updateImageWeb(fileAsBytes, key);
    return newVal[key];
  }

  Future<dynamic> updatePrefs(Map changed) async {
    final newVal = await settingsWebServices.updatePrefs(changed);
    return newVal;
  }
}
