import 'dart:convert';
import 'dart:io';
import 'package:reddit/data/web_services/settings_web_services.dart';

class EndDrawerRepository {
  final SettingsWebServices settingsWebServices;
  EndDrawerRepository(this.settingsWebServices);

  Future<dynamic> updateImage(String key, File val) async {
    final newVal = await settingsWebServices.updateImage(val, key);
    print(newVal);
    return jsonDecode(newVal)[key];
  }

  Future<dynamic> updatePrefs(Map changed) async {
    final newVal = await settingsWebServices.updatePrefs(changed);
    return newVal;
  }
}
