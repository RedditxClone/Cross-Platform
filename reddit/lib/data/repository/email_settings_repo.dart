import 'dart:convert';

import '../web_services/email_settings_web_services.dart';
import '../model/email_settings.dart';

class EmailSettingsRepository {
  final EmailSettingsWebServices emailSettingsWebServices;

  EmailSettingsRepository(this.emailSettingsWebServices);

  Future<EmailSettings> getEmailSettings() async {
    final emailSettingsData = await emailSettingsWebServices.getEmailSettings();
    return EmailSettings.fromJson(jsonDecode(emailSettingsData));
  }

  Future<void> updateEmailSettings(EmailSettings updatedEmailSettings) async {
    Map<String, bool> settingsMap = updatedEmailSettings.toJson();
    await emailSettingsWebServices.updateEmailSettings(settingsMap);
  }
}

