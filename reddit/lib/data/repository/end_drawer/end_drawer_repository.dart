import 'dart:convert';
import 'dart:io';
import 'package:reddit/data/web_services/settings_web_services.dart';

class EndDrawerRepository {
  final SettingsWebServices settingsWebServices;
  EndDrawerRepository(this.settingsWebServices);

  /// [key] : [String] that defines the type of photo we want to change 'coverPhoto' or 'profilePhoto'
  /// [val] : The new photo as a [File].
  /// Returns the path of the updated image or null if and error occured
  /// This function calls the function [SettingsWebServices.updateImage] that updates any photo on mobile.
  Future<dynamic> updateImage(String key, File val) async {
    final newVal = await settingsWebServices.updateImage(val, key);
    print(newVal);
    return jsonDecode(newVal)[key];
  }
}
