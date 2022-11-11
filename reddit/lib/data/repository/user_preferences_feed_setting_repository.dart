import 'package:reddit/data/model/user_preferences_feed_setting_model.dart';

import '../web_services/user_preferences_feed_setting_web_services.dart';

/// Repo for Reciveng data from Web Server.
///
/// Then Model it.
/// Then Sending it to Cubit.
class UserPreferencesFeedSettingRepository {
  final UserPreferencesFeedSettingWebServices feedSettingsWebServices;

  UserPreferencesFeedSettingRepository({
    required this.feedSettingsWebServices,
  });

  /// Map new Feed settings to Json and send it to web services class to make the PATCH request.
  /// The cubit (feed_settings_cubit) calls this function
  Future<int> updateFeedSettings(
      UserPreferencesFeedSettingModel newFeedSettings) async {
    Map<String, dynamic> jsonMap = newFeedSettings.toJson();
    return await feedSettingsWebServices.updateFeedSetting(jsonMap);
  }
}
