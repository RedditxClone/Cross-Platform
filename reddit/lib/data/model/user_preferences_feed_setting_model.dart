/// Model for Updating User Preferences (feed settings) sending to "/api/user/me/prefs".
class UserPreferencesFeedSettingModel {
  late bool adultContent;
  late bool autoPlayMedia;

  UserPreferencesFeedSettingModel({
    required this.adultContent,
    required this.autoPlayMedia,
  });

  /// Map settings comming from web services to the model.
  UserPreferencesFeedSettingModel.fromJson(Map<String, dynamic> json) {
    adultContent = json['adultContent'];
    autoPlayMedia = json['autoPlayMedia'];
  }

  /// Map settings from model to Json to be sent to web services.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adultContent'] = adultContent;
    data['autoPlayMedia'] = autoPlayMedia;
    return data;
  }
}
