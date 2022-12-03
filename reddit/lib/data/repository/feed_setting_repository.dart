// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:reddit/data/model/feed_setting_model.dart';

import '../web_services/feed_setting_web_services.dart';

/// Repo for Reciveng data from Web Server.
///
/// Then Model it.
/// Then Sending it to Cubit.
class FeedSettingRepository {
  final FeedSettingWebServices feedSettingsWebServices;

  FeedSettingRepository({
    required this.feedSettingsWebServices,
  });

  /// Gets feed settings from web services class and maps it to the model.
  ///
  /// The cubit (feed_settings_cubit) calls this function.
  Future<FeedSettingModel> getFeedSettings() async {
    final feedSettings = await feedSettingsWebServices.getFeedSettings();
    print("feed settings from repo:");
    print("$feedSettings");
    return FeedSettingModel.fromJson(feedSettings);
  }

  /// Map new Feed settings to Json and send it to web services class to make the PATCH request.
  ///
  /// The cubit (feed_settings_cubit) calls this function.
  Future<void> updateFeedSettings(FeedSettingModel newFeedSettings) async {
    Map<String, dynamic> jsonMap = newFeedSettings.toJson();
    await feedSettingsWebServices.updateFeedSetting(jsonMap);
  }
}
