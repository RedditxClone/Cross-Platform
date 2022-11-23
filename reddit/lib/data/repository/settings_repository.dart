import 'dart:io';
import 'dart:typed_data';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class SettingsRepository {
  final SettingsWebServices settingsWebServices;
  SettingsRepository(this.settingsWebServices);

  /// Returns [ProfileSettings] object that contains all user's profile settings
  Future<ProfileSettings> getUserSettings() async {
    final settings = await settingsWebServices.getUserSettings();
    return ProfileSettings.fromjson(settings);
  }

  /// [key] : [String] that defines the type of photo we want to change 'coverPhoto' or 'profilePhoto'
  /// [val] : The new photo as a [File].
  ///
  /// Returns the path of the updated image or null if and error occured
  ///
  /// This function calls the function [SettingsWebServices.updateImage] that updates any photo on mobile.
  Future<dynamic> updateImage(String key, File val) async {
    final newVal = await settingsWebServices.updateImage(val, key);
    return newVal[key];
  }

  /// [key] : [String] that defines the type of photo we want to change 'coverPhoto' or 'profilePhoto'
  /// [fileAsBytes] : The new photo as a [Uint8List] type.
  ///
  /// Returns the path of the updated image or null if and error occured
  ///
  /// This function calls the function [SettingsWebServices.updateImageWeb] that updates any photo on web.
  Future<dynamic> updateImageWeb(String key, Uint8List fileAsBytes) async {
    final newVal = await settingsWebServices.updateImageWeb(fileAsBytes, key);
    return newVal[key];
  }

  /// [changed] : a [Map] that contains only the changed profile settings
  ///
  /// Returns status code 200 if success and 401 if an error occured
  Future<dynamic> updatePrefs(Map changed) async {
    final newVal = await settingsWebServices.updatePrefs(changed);
    return newVal;
  }
}
