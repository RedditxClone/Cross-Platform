/// Model for Updating User Preferences (feed settings) sending to "/api/user/me/prefs".
class FeedSettingModel {
  late bool adultContent;
  late bool autoPlayMedia;

  FeedSettingModel({
    required this.adultContent,
    required this.autoPlayMedia,
  });

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedSettingModel &&
          adultContent == other.adultContent &&
          autoPlayMedia == other.autoPlayMedia;

  /// Map settings comming from web services to the model.
  ///
  /// The repository (feed_settings_repository) calls this function.
  /// It's parameter is json item to be sent to Web Server.
  FeedSettingModel.fromJson(Map<String, dynamic> json) {
    adultContent = json['adultContent'];
    autoPlayMedia = json['autoPlayMedia'];
  }

  /// Map settings from model to Json to be sent to web services.
  ///
  /// The repository (feed_settings_repository) calls this function.
  /// return json item to be sent to Web Server.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adultContent'] = adultContent;
    data['autoPlayMedia'] = autoPlayMedia;
    return data;
  }
}
