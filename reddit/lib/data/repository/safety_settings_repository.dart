import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';

class SafetySettingsRepository {
  final SafetySettingsWebServices settingsWebServices;
  SafetySettingsRepository(this.settingsWebServices);

  /// Returns all user settings from json to Settings class object
  Future<SafetySettings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return SafetySettings.fromjson(settings);
  }

  /// check if the username entered exist
  Future<dynamic> checkUsernameAvailable(String username) async {
    final newVal = await settingsWebServices.checkUsernameAvailable(username);
    return newVal;
  }

  /// block a user if existed
  Future<dynamic> blockUser(String username) async {
    final newVal = await settingsWebServices.blockUser(username);
    return newVal;
  }

  /// unblock a user if existed
  Future<dynamic> unBlockUser(String username) async {
    final newVal = await settingsWebServices.unBlockUser(username);
    return newVal;
  }

  /// get the list of blocked users blocked by the me
  Future<List<dynamic>> getBlockedUsers() async {
    final newVal = await settingsWebServices.getBlockedUsers();
    return newVal['blocked'];
  }

  /// patch to update all user settings
  Future<dynamic> updatePrefs(Map changed) async {
    final newVal = await settingsWebServices.updatePrefs(changed);
    return newVal;
  }
}
