import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';

class SafetySettingsRepository {
  final SafetySettingsWebServices settingsWebServices;
  SafetySettingsRepository(this.settingsWebServices);

  /// Returns [SafetySettings] object that contains all user's safety settings
  Future<SafetySettings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return SafetySettings.fromjson(settings);
  }

  /// [username] : the username we want to check his/her existance
  ///
  /// Returns status code 200 if success and 401 if an error occured
  Future<dynamic> checkUsernameAvailable(String username) async {
    final newVal = await settingsWebServices.checkUsernameAvailable(username);
    return newVal;
  }

  /// [username] : the username we want to block
  ///
  /// Returns status code 200 if success and 401 if an error occured
  Future<dynamic> blockUser(String username) async {
    final newVal = await settingsWebServices.blockUser(username);
    return newVal;
  }

  /// [username] : the username we want to unblock
  ///
  /// Returns status code 200 if success and 401 if an error occured
  Future<dynamic> unBlockUser(String username) async {
    final newVal = await settingsWebServices.unBlockUser(username);
    return newVal;
  }

  /// Returns [List] of the blocked users
  Future<List<dynamic>> getBlockedUsers() async {
    final newVal = await settingsWebServices.getBlockedUsers();
    return newVal;
  }

  /// [changed] : a [Map] that contains only the changed safety settings
  ///
  /// Returns status code 200 if success and 401 if an error occured
  Future<dynamic> updatePrefs(Map changed) async {
    final newVal = await settingsWebServices.updatePrefs(changed);
    return newVal;
  }
}
